require 'dry/component/container'

module Dry
  module Web
    class Container < Dry::Component::Container
      setting :env, ENV.fetch('RACK_ENV', 'development').to_sym
    end
  end
end
