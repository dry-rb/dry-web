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
      if !configured?
        super() do |config|
          app_config = Config.load(root, env)
          config.app = app_config if app_config
        end

        load_paths!('core')

        @_configured = true
      end

      yield(self)

      self
    end

    def self.configured?
      @_configured
    end

    def self.finalize!(&block)
      yield(self) if block

      Dir[root.join('core/boot/**/*.rb')].each(&method(:require))
      Dir[root.join('core/container/**/*.rb')].each(&method(:require))

      if config.auto_register
        Array(config.auto_register).each(&method(:auto_register!))
      end

      freeze
    end

    def self.import_module
      container = self
      auto_inject = Dry::AutoInject.new { container(container) }

      -> *keys {
        keys.each { |key| load_component(key) unless key?(key) }
        auto_inject[*keys]
      }
    end

    def self.auto_register!(dir, &block)
      dir_root = root.join(dir.to_s.split('/')[0])

      Dir["#{root}/#{dir}/**/*.rb"].each do |path|
        component_path = path.to_s.gsub("#{dir_root}/", '').gsub('.rb', '')

        klass_name = Inflecto.camelize(component_path)
        identifier = component_path.gsub('/', '.')

        next if key?(identifier)

        Kernel.require dir_root.join(component_path)

        if block
          register(identifier, yield(klass_name))
        else
          register(identifier) { const(klass_name).new }
        end
      end

      self
    end

    def self.boot!(component)
      require "core/boot/#{component}.rb"
    end

    def self.require(*paths)
      paths
        .flat_map { |path|
          path.include?('*') ? Dir[root.join(path)] : root.join(path)
        }
        .each { |path|
          Kernel.require path
        }
    end

    def self.load_component(key)
      require_component(key) { |klass| register(key) { klass.new } }
    end

    def self.require_component(key, &block)
      file = "#{key.gsub('.', '/')}.rb"
      path = load_paths.detect { |p| p.join(file).exist? }

      if path
        Kernel.require path.join(file).to_s
        yield(const(key)) if block
      else
        raise ArgumentError, "could not resolve require file for #{key}"
      end
    end

    def self.const(name)
      Inflecto.constantize(Inflecto.camelize(name.gsub('.', '/')))
    end

    def self.root
      config.root
    end

    def self.load_paths!(*dirs)
      dirs.map(&:to_s).each do |dir|
        path = root.join(dir)
        load_paths << path
        $LOAD_PATH.unshift(path.to_s)
      end
      self
    end

    def self.load_paths
      @_load_paths ||= []
    end
  end
end
