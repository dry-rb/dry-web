require 'dry/component/container'
require "dry/web/config"

module Dry
  module Web
    class Container < Dry::Component::Container
      setting :env, ENV.fetch('RACK_ENV', 'development').to_sym
    end
  end
end
