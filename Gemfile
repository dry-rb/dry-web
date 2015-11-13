source 'https://rubygems.org'

# Specify your gem's dependencies in rodakase.gemspec
gemspec

group :test do
  gem 'byebug', platform: :mri
  gem 'rack-test'
  gem 'slim'
  gem 'anima', '~> 0.2.0' # >= 0.3.0 requires MRI >= 2.2

  gem 'pg', platforms: [:mri, :rbx]
  gem 'pg_jruby', platform: :jruby
  gem 'database_cleaner'

  gem 'dry-data'
  gem 'transproc', github: 'solnic/transproc', branch: 'master'

  gem 'rom', github: 'rom-rb/rom', branch: 'master'
  gem 'rom-repository', github: 'rom-rb/rom-repository', branch: 'master'
  gem 'rom-sql', github: 'rom-rb/rom-sql', branch: 'master'
  gem 'rom-support', github: 'rom-rb/rom-support', branch: 'master'
  gem 'rom-mapper', github: 'rom-rb/rom-mapper', branch: 'master'

  gem 'codeclimate-test-reporter', platform: :rbx
end

group :tools do
  gem 'pry'
end

group :benchmarks do
  gem 'benchmark-ips'
  gem 'actionview'
end
