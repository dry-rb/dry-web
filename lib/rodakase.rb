require 'roda'
require 'logger'

require 'inflecto'
require 'dry-container'
require 'dry-auto_inject'
require 'dry-configurable'

require 'rodakase/version'
require 'rodakase/renderer'
require 'roda/plugins/flow'

module Rodakase
  class Container
    include Dry::Container::Mixin

    def auto_load!(root)
      root_size = root.to_s.split('/').size

      Dir[root.join('**/**.rb')].each do |path|
        path_split = path.to_s.split('/')
        path_size = path_split.size

        component_path = path_split[root_size-path_size..path_size]
          .join('/')
          .gsub('.rb', '')

        klass = Inflecto.camelize(component_path)

        require root.join(component_path)

        name = component_path.gsub('/', '.')

        register(name) { Inflecto.constantize(klass).new }
      end
    end
  end

  class Application < Roda
    extend Dry::Configurable

    setting :root
    setting :auto_container, false

    plugin :multi_route
    plugin :all_verbs

    plugin :flow

    def self.container(&block)
      @container ||= Container.new

      response = yield(@container, config)

      if response == @container
        @container.auto_load!(config.root.join('lib')) if config.auto_container
      end

      @container
    end

    def self.resolve(name)
      @container[name]
    end

    def self.[](name)
      resolve(name)
    end

    def self.load_routes!
      Dir[config.root.join('routes/**/*.rb')].each { |f| require f }
    end
  end
end
