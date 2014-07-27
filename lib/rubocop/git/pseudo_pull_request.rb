module RuboCop
  module Git
    # ref. https://github.com/thoughtbot/hound/blob/d2f3933/app/models/pull_request.rb
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
        return unless @options.hound
        File.read(HOUND_CONFIG_FILE)
      rescue Errno::ENOENT
        nil
      end

      private

      def build_commit_file(file)
        CommitFile.new(file, head_commit)
      end

      def head_commit
        @head_commit ||= Commit.new(@options)
      end
    end
  end
end
