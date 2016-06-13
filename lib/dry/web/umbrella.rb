require "dry/web/config"

module Dry
  module Web
    class Umbrella < Dry::Web::Container
      setting :options, Object.new

      def self.options
        config.options
      end
    end
  end
end
