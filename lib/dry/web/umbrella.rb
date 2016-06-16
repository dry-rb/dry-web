module Dry
  module Web
    class Umbrella < Dry::Web::Container
      EmptySettings = Class.new

      setting :settings_loader
      setting :settings, EmptySettings.new

      def self.configure(env = config.env, &block)
        super() do |config|
          yield(config) if block

          if config.settings_loader && config.settings.kind_of?(EmptySettings)
            config.settings = config.settings_loader.load(root, env)
          end
        end

        self
      end
    end
  end
end
