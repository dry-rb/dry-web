require 'yaml'

module Rodakase
  class Config
    extend Dry::Configurable

    def self.load(root, env)
      yaml = YAML.load_file(root.join('config').join('application.yml'))

      yaml.fetch(env.to_s).each do |key, value|
        setting key.downcase.to_sym, ENV.fetch(key, value)
      end

      config
    end
  end
end
