require "dry/web/settings"

module Dry
  module Web
    class Umbrella < Dry::Web::Container
      setting :settings

      def self.configure(env = config.env, &block)
        super() do |config|
          yield(config) if block

          config.settings = Settings.load(root, env) unless config.settings
        end

        self
      end
    end
  end
end
