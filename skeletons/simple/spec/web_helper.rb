require 'spec_helper'

require 'rack/test'

require_relative '../core/boot'

module AppHelper
  def app
    Simple::Application.app
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    Simple::Application.freeze
  end

  config.include Rack::Test::Methods, type: :request
  config.include AppHelper, type: :request
end
