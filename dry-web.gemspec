# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dry/web/version'

Gem::Specification.new do |spec|
  spec.name          = "dry-web"
  spec.version       = Dry::Web::VERSION
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]
  spec.summary       = "Lightweight web application stack on top of dry-component"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/dry-rb/dry-web"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "dry-component", "~> 0"
  spec.add_runtime_dependency "dry-transaction", "~> 0.5"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "simplecov", "~> 0.10.0"
end
