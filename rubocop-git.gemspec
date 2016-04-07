# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubocop/git/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-git'
  spec.version       = RuboCop::Git::VERSION
  spec.authors       = ['Masaki Takeuchi']
  spec.email         = ['m.ishihara@gmail.com']
  spec.summary       = %q{RuboCop for git diff.}
  spec.description   = %q{RuboCop for git diff.}
  spec.homepage      = 'https://github.com/m4i/rubocop-git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'appraisal'

  spec.add_dependency 'rubocop', '>= 0.24.1'
end
