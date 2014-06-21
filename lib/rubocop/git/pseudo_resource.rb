module RuboCop
  module Git
    class PseudoResource < Struct.new(:filename, :status, :patch)
    end
  end
end
