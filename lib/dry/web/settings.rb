require "yaml"

module Dry
  module Web
    class Settings
      AnyType = Class.new do
        def self.[](value)
          value
        end
      end

      def self.schema
        @schema ||= {}
      end

      def self.setting(name, type = AnyType)
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
        yaml_data = File.exist?(yaml_path) ? YAML.load_file(yaml_path)[env.to_s] : {}
        schema = self.schema

        Class.new do
          extend Dry::Configurable

          schema.each do |key, type|
            value = ENV.fetch(key.to_s.upcase) { yaml_data[key.to_s.downcase] }
            value = type[value]

            setting key, value
          end
        end.config
      end
    end
  end
end
