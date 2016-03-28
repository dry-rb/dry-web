source 'https://rubygems.org'

# Specify your gem's dependencies in rodakase.gemspec
gemspec

gem 'dry-component', github: 'dryrb/dry-component', branch: 'master'
gem 'transflow', github: 'timriley/transflow', branch: 'fix-step-bug'

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
