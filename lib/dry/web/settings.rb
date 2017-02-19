require "dry/web/parser"

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
        env_file = find_env_file(root, env)
        return {} unless env_file
        parse_file(env_file)
      end
      private_class_method :extract_environment_data

      def self.find_env_file(root, env)
        root.each_child.find { |path| path.basename.fnmatch(".env.#{env}") }
      end
      private_class_method :find_env_file

      def self.parse_file(file)
        Parser.call(file)
      end
      private_class_method :parse_file

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
