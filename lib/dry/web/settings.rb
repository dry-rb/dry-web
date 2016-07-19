require "yaml"
require "erb"

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

      def self.load(root, env)
        yaml_path = root.join("config/settings.yml")
        yaml_data = File.exist?(yaml_path) ? YAML.load(ERB.new(File.read(yaml_path)).result)[env.to_s] : {}
        schema = self.schema

        Class.new do
          extend Dry::Configurable

          schema.each do |key, type|
            value = ENV.fetch(key.to_s.upcase) { yaml_data[key.to_s.downcase] }

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
