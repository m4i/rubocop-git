require_relative '../../test_helper'
require 'rubocop/git/runner'

describe RuboCop::Git::Runner do
  it 'fail with invalid options' do
    proc do
      _out, _err = capture_io do
        RuboCop::Git::Runner.new.run({})
      end
    end.must_raise(RuboCop::Git::Options::Invalid)
  end
end
