require 'roda'
require 'dry-configurable'

module Rodakase
  class Application < Roda
    extend Dry::Configurable

    setting :container

    plugin :multi_route
    plugin :all_verbs

    plugin :flow

    def self.resolve(name)
      config.container[name]
    end

    def self.[](name)
      resolve(name)
    end

    def self.load_routes!
      Dir[root.join('web/routes/**/*.rb')].each { |f| require f }
    end

    def self.root
      config.container.config.root
    end
  end
end
