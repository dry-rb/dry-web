require 'inflecto'
require 'dry-container'
require 'dry-auto_inject'

module Rodakase
  class Container
    extend Dry::Container::Mixin

    setting :root
    setting :auto_load

    def self.configure(&block)
      response = yield(self)

      Dir[root.join('core/container/**/*.rb')].each(&method(:require))

      if response == self
        auto_load!(root.join('lib')) if config.auto_load
      end

      self
    end

    def self.import
      container = self
      Dry::AutoInject.new { container(container) }
    end

    def self.auto_load!(root)
      root_size = root.to_s.split('/').size

      Dir[root.join('**/**.rb')].each do |path|
        path_split = path.to_s.split('/')
        path_size = path_split.size

        component_path = path_split[root_size-path_size..path_size]
          .join('/')
          .gsub('.rb', '')

        klass = Inflecto.camelize(component_path)

        name = component_path.gsub('/', '.')

        # FIXME: we need a public API in dry-container
        next if _container.key?(name)

        register(name) do
          require root.join(component_path)
          Inflecto.constantize(klass).new
        end
      end
    end

    def self.root
      config.root
    end
  end
end
