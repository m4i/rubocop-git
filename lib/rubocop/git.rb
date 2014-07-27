require 'rubocop/git/version'
require 'rubocop'

module RuboCop
  module Git
    autoload :Commit,            'rubocop/git/commit'
    autoload :CommitFile,        'rubocop/git/commit_file'
    autoload :DiffParser,        'rubocop/git/diff_parser'
    autoload :FileViolation,     'rubocop/git/file_violation'
    autoload :Line,              'rubocop/git/line'
    autoload :Options,           'rubocop/git/options'
    autoload :Patch,             'rubocop/git/patch'
    autoload :PseudoPullRequest, 'rubocop/git/pseudo_pull_request'
    autoload :PseudoResource,    'rubocop/git/pseudo_resource'
    autoload :Runner,            'rubocop/git/runner'
    autoload :StyleChecker,      'rubocop/git/style_checker'
    autoload :StyleGuide,        'rubocop/git/style_guide'
  end
end
