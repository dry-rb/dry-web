require 'roda'
require 'logger'
require 'dry-container'
require 'dry-auto_inject'
require 'dry-configurable'

require 'rodakase/version'

module Rodakase
  class Container
    include Dry::Container::Mixin
  end

  class Application < Roda
    extend Dry::Configurable

    setting :root

    def self.container(&block)
      @container ||= Container.new
      yield(@container, config)
    end

    def self.[](name)
      @container[name]
    end
  end
end
