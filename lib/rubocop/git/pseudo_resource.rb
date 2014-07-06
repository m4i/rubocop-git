module RuboCop
  module Git
    class PseudoResource
      attr_reader :filename, :patch

      def initialize(filename)
        @filename = filename
        @patch    = ''
      end

      def status
        'modified'
      end
    end
  end
end
