require 'inflecto'
require 'dry-container'
require 'dry-auto_inject'

require 'rodakase/config'

module Rodakase
  class Container
    extend Dry::Container::Mixin

    setting :env, ENV.fetch('RACK_ENV', :development).to_sym
    setting :root, Pathname.pwd.freeze
    setting :auto_register
    setting :app

    def self.configure(env = config.env, &block)
      super() do |config|
        app_config = Config.load(root, env)
        config.app = app_config if app_config
      end

      response = yield(self)

      load_paths!('core')

      Dir[root.join('core/boot/**/*.rb')].each(&method(:require))
      Dir[root.join('core/container/**/*.rb')].each(&method(:require))

      if response == self && config.auto_register
        Array(config.auto_register).each(&method(:auto_register!))
        auto_registered_paths.each(&method(:require))
      end

      freeze
    end

    def self.import_module
      container = self
      Dry::AutoInject.new { container(container) }
    end

    def self.auto_register!(dir, &block)
      dir_root = root.join(dir.to_s.split('/')[0])

      Dir["#{root}/#{dir}/**/*.rb"].each do |path|
        component_path = path.to_s.gsub("#{dir_root}/", '').gsub('.rb', '')

        klass_name = Inflecto.camelize(component_path)
        identifier = component_path.gsub('/', '.')

        next if _container.key?(identifier)

        auto_registered_paths << dir_root.join(component_path).to_s

        if block
          register(identifier, yield(klass_name))
        else
          register(identifier) do
            Inflecto.constantize(klass_name).new
          end
        end
      end

      self
    end

    def self.root
      config.root
    end

    def self.load_paths!(*dirs)
      dirs.each { |dir| $LOAD_PATH.unshift(root.join(dir)) }
    end

    def self.auto_registered_paths
      @_auto_registered_paths ||= []
    end
  end
end
