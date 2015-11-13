source 'https://rubygems.org'

# Specify your gem's dependencies in rodakase.gemspec
gemspec

group :test do
  gem 'byebug', platform: :mri
  gem 'rack-test'
  gem 'slim'
  gem 'anima', '~> 0.2.0' # >= 0.3.0 requires MRI >= 2.2

  gem 'dry-data'

  gem 'codeclimate-test-reporter', platform: :rbx
end

group :tools do
  gem 'pry'
end

group :benchmarks do
  gem 'benchmark-ips'
  gem 'actionview'
end
