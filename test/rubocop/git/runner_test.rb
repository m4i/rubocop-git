require_relative '../../test_helper'
require 'rubocop/git/runner'

describe RuboCop::Git::Runner do
  it 'exit with violations' do
    options = RuboCop::Git::Options.new
    # lib/rubocop/git/runner.rb:14:1: C: Trailing whitespace detected.
    options.commits = ["v0.0.4", "v0.0.5"]
    proc do
      _out, _err = capture_io do
        RuboCop::Git::Runner.new.run(options)
      end
    end.must_raise(SystemExit)
  end

  it 'fail with no options' do
    proc do
      _out, _err = capture_io do
        RuboCop::Git::Runner.new.run({})
      end
    end.must_raise(RuboCop::Git::Options::Invalid)
  end
end
