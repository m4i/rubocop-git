require 'shellwords'

module RuboCop
  module Git
    # ref. https://github.com/thoughtbot/hound/blob/be2dd34/app/models/pull_request.rb
    class PseudoPullRequest
      HOUND_CONFIG_FILE = '.hound.yml'

      def initialize(files, options)
        @files = files
        @options = options
      end

      def pull_request_files
        @files.map do |file|
          build_commit_file(file)
        end
      end

      def config
        return unless @options[:hound]
        File.read(HOUND_CONFIG_FILE)
      rescue Errno::ENOENT
        nil
      end

      private

      def build_commit_file(file)
        CommitFile.new(file, file_contents(file.filename))
      end

      def file_contents(filename)
        if @options[:cached]
          `git show :#{filename.shellescape}`
        else
          File.read(filename)
        end
      end
    end
  end
end
