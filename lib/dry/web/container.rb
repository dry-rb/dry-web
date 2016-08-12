require 'dry/system/container'

module Dry
  module Web
    class Container < Dry::System::Container
      setting :env, ENV.fetch('RACK_ENV', 'development').to_sym
    end
  end
end
