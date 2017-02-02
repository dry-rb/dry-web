require 'dry/system/container'
require 'dry/monitor'

module Dry
  module Web
    class Container < Dry::System::Container
      setting :env, ENV.fetch('RACK_ENV', 'development').to_sym
      setting :log_dir, 'log'.freeze
      setting :log_levels, development: Logger::DEBUG
      setting :logger
      setting :listeners, false

      class << self
        def configure(&block)
          super.
            configure_logger.
            configure_notifications.
            configure_rack_monitor.
            attach_listeners
        end

        def configure_logger
          if key?(:logger)
            self
          elsif config.logger
            register(:logger, config.logger)
          else
            config.logger = Monitor::Logger.new(config.root.join(config.log_dir).realpath.join("#{config.env}.log"))
            config.logger.level = config.log_levels.fetch(config.env, Logger::ERROR)
            register(:logger, config.logger)
            self
          end
        end

        def configure_notifications
          return self if key?(:notifications)
          register(:notifications, Monitor::Notifications.new(config.name))
          self
        end

        def configure_rack_monitor
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
