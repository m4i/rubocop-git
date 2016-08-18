module RuboCop
  module Git
    class PseudoResource
      attr_reader :patch

      def initialize(filename)
        @filename = filename
        @patch    = ''
      end

      def filename
        "#{Dir.pwd}/#{@filename}"
      end

      def status
        'modified'
      end
    end
  end
end
