require "dry/web/environment_data"

module Dry
  module Web
    class Settings
      SettingValueError = Class.new(StandardError)

      def self.schema
        @schema ||= {}
      end

      def self.setting(name, type = nil)
        settings(name => type)
      end

      def self.settings(new_schema)
        check_schema_duplication(new_schema)
        @schema = schema.merge(new_schema)

        self
      end

      def self.check_schema_duplication(new_schema)
        shared_keys = new_schema.keys & schema.keys

        raise ArgumentError, "Setting :#{shared_keys.first} has already been defined" if shared_keys.any?
      end
      private_class_method :check_schema_duplication

      def self.extract_environment_data(root, env)
        EnvironmentData.new.(root, env)
      end
      private_class_method :extract_environment_data

      def self.load(root, env)
        env_data = extract_environment_data(root, env)
        schema = self.schema

        Class.new do
          extend Dry::Configurable

          schema.each do |key, type|
            value = ENV.fetch(key.to_s.upcase) { env_data[key.to_s.upcase] }

            begin
              value = type[value] if type
            rescue => e
              raise SettingValueError, "error typecasting +#{key}+: #{e}"
            end

            setting key, value
          end
        end.config
      end
    end
  end
end
