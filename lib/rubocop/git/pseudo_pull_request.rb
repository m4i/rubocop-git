require 'shellwords'

module RuboCop
  module Git
    # ref. https://github.com/thoughtbot/hound/blob/a6a8d3f/app/models/pull_request.rb
    class PseudoPullRequest
      HOUND_CONFIG_FILE = '.hound.yml'

      def initialize(files, options)
        @files = files
        @options = options
      end

      def pull_request_files
        @files.map do |file|
          ModifiedFile.new(file, self)
        end
      end

      def file_contents(filename)
        if @options[:cached]
          `git show :#{filename.shellescape}`
        else
          File.read(filename)
        end
      end

      def config
        return unless @options[:hound]
        File.read(HOUND_CONFIG_FILE)
      rescue Errno::ENOENT
        nil
      end
    end
  end
end
