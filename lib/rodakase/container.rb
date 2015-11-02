require 'inflecto'

module Rodakase
  class Container
    include Dry::Container::Mixin

    setting :root
    setting :auto_load

    def self.configure(&block)
      response = yield(config)

      if response == instance
        instance.auto_load!(config.root.join('lib')) if config.auto_load
      end

      instance
    end

    def self.register(*args, &block)
      instance.register(*args, &block)
    end

    def self.instance
      @instance ||= new
    end

    def self.import
      container = instance
      Dry::AutoInject.new { container(container) }
    end

    def auto_load!(root)
      root_size = root.to_s.split('/').size

      Dir[root.join('**/**.rb')].each do |path|
        path_split = path.to_s.split('/')
        path_size = path_split.size

        component_path = path_split[root_size-path_size..path_size]
          .join('/')
          .gsub('.rb', '')

        klass = Inflecto.camelize(component_path)

        name = component_path.gsub('/', '.')

        register(name) do
          require root.join(component_path)
          Inflecto.constantize(klass).new
        end
      end
    end
  end
end
