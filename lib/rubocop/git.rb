require 'rubocop/git/version'
require 'rubocop'
require 'active_support/core_ext/module/attribute_accessors'

module RuboCop
  module Git
    autoload :FileCollection,    'rubocop/git/file_collection'
    autoload :FileViolation,     'rubocop/git/file_violation'
    autoload :Line,              'rubocop/git/line'
    autoload :ModifiedFile,      'rubocop/git/modified_file'
    autoload :Patch,             'rubocop/git/patch'
    autoload :PseudoPullRequest, 'rubocop/git/pseudo_pull_request'
    autoload :PseudoResource,    'rubocop/git/pseudo_resource'
    autoload :Runner,            'rubocop/git/runner'
    autoload :StyleChecker,      'rubocop/git/style_checker'
    autoload :StyleGuide,        'rubocop/git/style_guide'

    mattr_accessor :config_path
  end
end
