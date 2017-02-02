require 'dry/system/container'
require 'dry/monitor/logger'

module Dry
  module Web
    class Container < Dry::System::Container
      setting :env, ENV.fetch('RACK_ENV', 'development').to_sym
      setting :log_dir, 'log'.freeze
      setting :log_levels, development: Logger::DEBUG
      setting :logger

      class << self
        def configure(&block)
          super.configure_logger
        end

        def configure_logger
          if key?(:logger)
            self
          elsif config.logger
            register(:logger, config.logger)
          else
            config.logger = Monitor::Logger.new(config.root.join(config.log_dir).join("#{config.env}.log").realpath)
            config.logger.level = config.log_levels.fetch(config.env, Logger::ERROR)
            register(:logger, config.logger)
            self
          end
        end
      end
    end
  end
end
