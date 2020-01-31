require_relative 'support/coverage'

ENV['RACK_ENV'] = 'test'

begin
  require 'byebug'
rescue LoadError; end

SPEC_ROOT = Pathname(__FILE__).dirname

Dir[SPEC_ROOT.join('support/*.rb').to_s].each { |f| require f }
Dir[SPEC_ROOT.join('shared/*.rb').to_s].each { |f| require f }

require "dry-web"

module Test; end

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.before do
    @test_constants = Test.constants
  end

  config.after do
    added_constants = Test.constants - @test_constants
    added_constants.each { |name| Test.send(:remove_const, name) }
  end
end
