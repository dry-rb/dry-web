require "dry/web/container"

module Dry
  module Web
    class Umbrella < Dry::Web::Container
      setting :settings_loader
      setting :settings

      def self.configure(env = config.env, &block)
        super() do |config|
          yield(config) if block

          if config.settings_loader && config.settings.nil?
            config.settings = load_settings(config.settings_loader, root, env)
          end
        end

        self
      end

      def self.load_settings(loader, root, env)
        begin
          loader.load(root, env)
        rescue => e
          puts "Could not load your settings: #{e}"
          puts
          raise e
        end
      end
      private_class_method :load_settings
    end
  end
end
