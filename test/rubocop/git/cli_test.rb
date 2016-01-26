require_relative '../../test_helper'
require 'rubocop/git/cli'

describe RuboCop::Git::CLI do
  it 'fail with invalid options' do
    proc do
      _out, _err = capture_io do
        RuboCop::Git::CLI.new.run(['--gruß'])
      end
    end.must_raise(SystemExit)
  end
end
