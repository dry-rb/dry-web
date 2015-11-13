# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rodakase/version'

Gem::Specification.new do |spec|
  spec.name          = "rodakase"
  spec.version       = Rodakase::VERSION
  spec.authors       = ["Piotr Solnica"]
  spec.email         = ["piotr.solnica@gmail.com"]
  spec.summary       = "Lightweight web application stack on top of Roda"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/solnic/rodakase"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "inflecto"
  spec.add_runtime_dependency "roda", "~> 2.7"
  spec.add_runtime_dependency "tilt", "~> 2.0"
  spec.add_runtime_dependency "dry-equalizer", "~> 0.2"
  spec.add_runtime_dependency "dry-container", "~> 0.2"
  spec.add_runtime_dependency "dry-configurable", "~> 0.1"
  spec.add_runtime_dependency "dry-auto_inject", "~> 0.1"
  spec.add_runtime_dependency "transflow", "~> 0.3"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "capybara"
end
