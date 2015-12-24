require 'dry/component/container'

module Rodakase
  class Container < Dry::Component::Container
    setting :env, ENV.fetch('RACK_ENV', 'development').to_sym
  end
end
