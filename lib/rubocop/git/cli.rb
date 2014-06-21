require 'rubocop/git'
require 'optparse'

module RuboCop
  module Git
    class CLI
      def run(args = ARGV)
        options = parse_arguments(args)
        Runner.new.run(options)
      end

      private

      def parse_arguments(args)
        options = {}

        OptionParser.new do |opt|
          opt.on('-c', '--config FILE',
                 'Specify configuration file') do |config|
            options[:config] = config
          end

          opt.on('-D', '--display-cop-names',
                 'Display cop names in offense messages') do
            RuboCop::Git.options[:display_cop_names] = true
          end

          opt.on('--cached', 'git diff --cached') do
            options[:cached] = true
          end

          opt.on('--staged', 'synonym of --cached') do
            options[:cached] = true
          end

          opt.on('--hound', 'Hound compatibility mode') do
            options[:hound] = true
          end

          opt.parse(args)
        end

        options
      end
    end
  end
end
