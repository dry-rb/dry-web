# frozen_string_literal: true
# this file is managed by dry-rb/devtools project

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dry/system/version'

Gem::Specification.new do |spec|
  spec.name          = 'dry-system'
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]
  spec.license       = 'MIT'
  spec.version       = Dry::System::VERSION.dup

  spec.summary       = "Lightweight web application stack on top of dry-system"
  spec.description   = spec.summary
  spec.homepage      = 'https://dry-rb.org/gems/dry-system'
  spec.files         = Dir["CHANGELOG.md", "LICENSE", "README.md", "dry-system.gemspec", "lib/**/*"]
  spec.require_paths = ['lib']

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  spec.metadata['changelog_uri']     = 'https://github.com/dry-rb/dry-system/blob/master/CHANGELOG.md'
  spec.metadata['source_code_uri']   = 'https://github.com/dry-rb/dry-system'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/dry-rb/dry-system/issues'

  spec.required_ruby_version = ">= 2.4.0"

  # to update dependencies edit project.yml
  spec.add_runtime_dependency "dry-monitor", "~> 0.3"
  spec.add_runtime_dependency "dry-system", "~> 0.15"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
