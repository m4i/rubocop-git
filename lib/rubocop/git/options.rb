module RuboCop
  module Git
    class Options
      class Invalid < StandardError; end

      DEFAULT_CONFIG_FILE = '.rubocop.yml'
      HOUND_DEFAULT_CONFIG_FILE =
        File.expand_path('../../../../hound.yml', __FILE__)

      attr_accessor :config, :cached
      attr_reader   :hound, :rubocop

      def initialize(hash_options = nil)
        @config  = DEFAULT_CONFIG_FILE
        @cached  = false
        @hound   = false
        @rubocop = {}

        from_hash(hash_options) if hash_options
      end

      def hound=(hound_)
        if hound_ && RuboCop::Version.version != '0.22.0'
          fail Invalid, 'Hound compatibility mode requires rubocop 0.22.0'
        end
        @hound = !!hound_
      end

      def rubocop=(rubocop_)
        unless rubocop_.is_a?(Hash)
          fail Invalid, "invalid rubocop: #{rubocop_.inspect}"
        end
        @rubocop = rubocop_
      end

      def config_path
        hound ? HOUND_DEFAULT_CONFIG_FILE : config
      end

      private

      def from_hash(hash_options)
        hash_options = hash_options.dup
        %w(config cached hound rubocop commits).each do |key|
          public_send("#{key}=", hash_options.delete(key))
        end
        unless hash_options.empty?
          fail Invalid, "invalid keys: #{hash_options.keys.join(' ')}"
        end
      end
    end
  end
end
