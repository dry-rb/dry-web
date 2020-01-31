require 'dry/system/container'
require 'dry/monitor'

module Dry
  module Web
    class Container < Dry::System::Container
      use :env, inferrer: -> { ENV.fetch('RACK_ENV', 'development').to_sym }
      use :logging
      use :notifications

      setting :logger_class, Monitor::Logger
      setting :listeners, false

      def self.inherited(klass)
        klass.after(:configure) do
          register_rack_monitor
          attach_listeners
        end
        super
      end

      class << self
        def register_rack_monitor
          return self if key?(:rack_monitor)

          register(:rack_monitor, Monitor::Rack::Middleware.new(self[:notifications]))
          self
        end

        def attach_listeners
          return unless config.listeners

          rack_logger = Monitor::Rack::Logger.new(self[:logger])
          rack_logger.attach(self[:rack_monitor])
          self
        end
      end
    end
  end
end
