require 'shellwords'

module RuboCop
  module Git
    # ref. https://github.com/thoughtbot/hound/blob/d2f3933/app/models/commit.rb
    class Commit
      def initialize(options)
        @options = options
      end

      def file_content(filename)
        if @options.cached
          `git show :#{filename.shellescape}`
        elsif @options.commit_last
          `git show #{@options.commit_last.shellescape}:#{filename.shellescape}`
        else
          File.read(filename)
        end
      end
    end
  end
end
