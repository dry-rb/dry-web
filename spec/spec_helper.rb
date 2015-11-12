# encoding: utf-8

if RUBY_ENGINE == "rbx"
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

begin
  require 'byebug'
rescue LoadError; end

require 'rack/test'
require 'slim'

ENV['RACK_ENV'] = 'test'

SPEC_ROOT = Pathname(__FILE__).dirname

Dir[SPEC_ROOT.join('support/*.rb').to_s].each { |f| require f }
Dir[SPEC_ROOT.join('shared/*.rb').to_s].each { |f| require f }

require SPEC_ROOT.join('dummy/core/boot').to_s

require 'database_cleaner'

DatabaseCleaner[:sequel, connection: Helpers.db_conn].strategy = :transaction

module Test; end

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    Main::Application.freeze
  end

  config.include Rack::Test::Methods, type: :request
  config.include Helpers

  config.before do
    @test_constants = Test.constants
  end

  config.around do |e|
    DatabaseCleaner.cleaning { e.run }
  end

  config.after do
    added_constants = Test.constants - @test_constants
    added_constants.each { |name| Test.send(:remove_const, name) }
  end
end
