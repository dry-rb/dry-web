require 'inflecto'
require 'dry-container'
require 'dry-auto_inject'

require 'rodakase/config'

module Rodakase
  class Container
    extend Dry::Container::Mixin

    setting :root
    setting :auto_load
    setting :app

    def self.configure(env = :development, &block)
      super() do |config|
        config.app = Config.load(root, env)
      end

      response = yield(self)

      Dir[root.join('core/boot/**/*.rb')].each(&method(:require))
      Dir[root.join('core/container/**/*.rb')].each(&method(:require))

      if response == self && config.auto_load
        auto_load!(lib_path)
        auto_loaded_paths.each(&method(:require))
      end

      freeze
    end

    def self.import_module
      container = self
      Dry::AutoInject.new { container(container) }
    end

    def self.auto_load!(source_path, &block)
      Dir[source_path.join('**/*.rb')].each do |path|
        component_path = (path.to_s.split('/') - lib_path.to_s.split('/'))
          .join('/').gsub('.rb', '')

        klass_name = Inflecto.camelize(component_path)
        identifier = component_path.gsub('/', '.')

        next if _container.key?(identifier)

        auto_loaded_paths << lib_path.join(component_path).to_s

        if block
          register(identifier, yield(klass_name))
        else
          register(identifier) do
            Inflecto.constantize(klass_name).new
          end
        end
      end
    end

    def self.root
      config.root
    end

    def self.lib_path
      root.join('lib')
    end

    def self.auto_loaded_paths
      @_auto_loaded_paths ||= []
    end
  end
end
