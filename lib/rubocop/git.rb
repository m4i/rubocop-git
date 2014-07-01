require 'rubocop/git/version'
require 'rubocop'

module RuboCop
  module Git
    autoload :CommitFile,        'rubocop/git/commit_file'
    autoload :FileViolation,     'rubocop/git/file_violation'
    autoload :Line,              'rubocop/git/line'
    autoload :Patch,             'rubocop/git/patch'
    autoload :PseudoPullRequest, 'rubocop/git/pseudo_pull_request'
    autoload :PseudoResource,    'rubocop/git/pseudo_resource'
    autoload :Runner,            'rubocop/git/runner'
    autoload :StyleChecker,      'rubocop/git/style_checker'
    autoload :StyleGuide,        'rubocop/git/style_guide'
  end
end
