require 'rubocop/git'
require 'optparse'

module RuboCop
  module Git
    class CLI
      def run(args = ARGV)
        @options = Options.new
        parse_arguments(args)
        Runner.new.run(@options)
      end

      private

      def parse_arguments(args)
        @options.commits = option_parser.parse(args)
      rescue OptionParser::InvalidOption, Options::Invalid => ex
        warn "ERROR: #{ex.message}"
        $stderr.puts
        warn option_parser
        exit 1
      end

      def option_parser
        @option_parser ||= OptionParser.new do |opt|
          opt.banner << ' [[commit] commit]'

          opt.on('-c', '--config FILE',
                 'Specify configuration file') do |config|
            @options.config = config
          end

          opt.on('-r', '--require FILE',
                 'Require Ruby file') do |file|
            require file
          end

          opt.on('-a', '--auto-correct', 'Auto-correct offenses.') do
            @options.rubocop[:auto_correct] = true
          end

          opt.on('-d', '--debug', 'Display debug info') do
            @options.rubocop[:debug] = true
          end

          opt.on('-D', '--display-cop-names',
                 'Display cop names in offense messages') do
            @options.rubocop[:display_cop_names] = true
          end

          opt.on('--cached', 'git diff --cached') do
            @options.cached = true
          end

          opt.on('--staged', 'synonym of --cached') do
            @options.cached = true
          end

          opt.on('--hound', 'Hound compatibility mode') do
            @options.hound = true
          end

          opt.on('--version', 'Display version') do
            puts RuboCop::Git::VERSION
            exit 0
          end
        end
      end
    end
  end
end
