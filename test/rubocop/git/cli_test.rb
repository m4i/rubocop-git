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

  describe '--format' do
    it 'format clang' do
      out, _err = capture_io do
        RuboCop::Git::CLI.new.run(['--format', 'clang'])
      end
      out.must_match(/no offenses detected/)
    end

    it 'fail with missing argument' do
      proc do
        _out, _err = capture_io do
          RuboCop::Git::CLI.new.run(['--format'])
        end
      end.must_raise(OptionParser::MissingArgument)
    end

    it 'fail with RuntimeError' do
      proc do
        _out, _err = capture_io do
          RuboCop::Git::CLI.new.run(['--format', 'test'])
        end
      end.must_raise(RuntimeError)
    end
  end
end
