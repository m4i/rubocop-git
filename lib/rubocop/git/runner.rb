module RuboCop
  module Git
    # ref. https://github.com/thoughtbot/hound/blob/a6a8d3f/app/services/build_runner.rb
    class Runner
      DEFAULT_CONFIG_FILE = '.rubocop.yml'
      HOUND_DEFAULT_CONFIG_FILE =
        File.expand_path('../../../../hound.yml', __FILE__)

      def run(options)
        @options = options
        @files = parse_diff(git_diff(options[:cached]))

        set_config_path(options[:config], options[:hound])
        display_violations($stdout)
      end

      private

      def violations
        @violations ||= style_checker.violations
      end

      def style_checker
        StyleChecker.new(modified_files, pull_request.config)
      end

      def modified_files
        collection = FileCollection.new(pull_request.pull_request_files)
        collection.relevant_files
      end

      def pull_request
        @pull_request ||= PseudoPullRequest.new(@files, @options)
      end

      def git_diff(cached)
        if cached
          `git diff --cached --diff-filter=AM`
        else
          `git diff --diff-filter=AM`
        end
      end

      def parse_diff(diff)
        files    = []
        in_patch = false

        diff.each_line do |line|
          case line
          when %r{^diff --git a/(.*) b/\1$}
            files << PseudoResource.new($1, 'modified', '')
            in_patch = false
          when /^@@/
            in_patch = true
          end

          files.last.patch << line if in_patch
        end

        files
      end

      def set_config_path(config, hound)
        RuboCop::Git.config_path =
          if hound
            HOUND_DEFAULT_CONFIG_FILE
          else
            config || DEFAULT_CONFIG_FILE
          end
      end

      def display_violations(io)
        formatter = Rubocop::Formatter::ClangStyleFormatter.new(io)
        formatter.started(nil)

        violations.map do |violation|
          formatter.file_finished(
            violation.filename,
            violation.offenses.compact.sort.freeze
          )
        end

        formatter.finished(@files.map(&:filename).freeze)
      end
    end
  end
end
