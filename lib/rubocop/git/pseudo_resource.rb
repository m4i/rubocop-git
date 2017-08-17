module RuboCop
  module Git
    class PseudoResource
      attr_reader :patch, :pwd, :file_relative_path

      alias_method :filename, :file_relative_path

      def initialize(file_relative_path, pwd = Dir.pwd)
        @file_relative_path = file_relative_path
        @pwd = pwd
        @patch = ''
      end

      def absolute_path
        filename
        File.join(pwd, filename)
      end

      def status
        'modified'
      end
    end
  end
end
