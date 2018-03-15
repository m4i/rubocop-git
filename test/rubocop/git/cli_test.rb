require_relative '../../test_helper'
require 'rubocop/git/cli'

describe RuboCop::Git::CLI do
  it 'exit with violations' do
    # lib/rubocop/git/runner.rb:14:1: C: Trailing whitespace detected.
    commits = ["v0.0.4", "v0.0.5"]
    proc do
      _out, _err = capture_io do
        RuboCop::Git::CLI.new.run(commits)
      end
    end.must_raise(SystemExit)
  end

  it 'fail with invalid options' do
    proc do
      _out, _err = capture_io do
        RuboCop::Git::CLI.new.run(['--gruß'])
      end
    end.must_raise(SystemExit)
  end
end
