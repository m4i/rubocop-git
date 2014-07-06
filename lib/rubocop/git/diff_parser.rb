module RuboCop
  module Git
    class DiffParser
      class << self
        def parse(diff)
          new.parse(diff)
        end
      end

      def parse(diff)
        files    = []
        in_patch = false

        diff.each_line do |line|
          case line
          when /^diff --git/
            in_patch = false
          when %r{^\+{3} b/(?<path>[^\t\n\r]+)}
            files << PseudoResource.new(Regexp.last_match[:path])
          when /^@@/
            in_patch = true
          end

          files.last.patch << line if in_patch
        end

        files
      end
    end
  end
end
