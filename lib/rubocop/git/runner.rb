require 'shellwords'

module RuboCop
  module Git
    # ref. https://github.com/thoughtbot/hound/blob/be2dd34/app/services/build_runner.rb
    class Runner
      def run(options)
        options = Options.new(options) unless options.is_a?(Options)

        @options = options
        @files = DiffParser.parse(git_diff(options))

        display_violations($stdout)
      end

      private

      def violations
        @violations ||= style_checker.violations
      end

      def style_checker
        StyleChecker.new(pull_request.pull_request_files,
                         @options.rubocop,
                         @options.config_path,
                         pull_request.config)
      end

      def pull_request
        @pull_request ||= PseudoPullRequest.new(@files, @options)
      end

      def git_diff(options)
        args = %w(diff --diff-filter=AMCR --find-renames --find-copies)

        if options.cached
          args << '--cached'
        elsif options.commit_last
          args << options.commit_first.shellescape
          args << options.commit_last.shellescape
        end

        `git #{args.join(' ')}`
      end

      def display_violations(io)
        formatter = RuboCop::Formatter::ClangStyleFormatter.new(io)
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
