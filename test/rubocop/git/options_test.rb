require_relative '../../test_helper'
require 'rubocop/git/options'

describe RuboCop::Git::Options do
  it 'fail with no options' do
    proc do
      RuboCop::Git::Options.new({})
    end.must_raise(RuboCop::Git::Options::Invalid)
  end

  it 'can pass string hash options' do
    RuboCop::Git::Options.new('rubocop' => {}, 'commits' => [])
  end

  it 'can pass symbol hash options' do
    RuboCop::Git::Options.new(rubocop: {}, commits: [])
  end
end
