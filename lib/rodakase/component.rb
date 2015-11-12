require 'inflecto'

module Rodakase
  def self.Component(input)
    Component.new(Component.identifier(input), Component.path(input))
  end

  class Component
    IDENTIFIER_SEPARATOR = '.'.freeze
    PATH_SEPARATOR = '/'.freeze

    attr_reader :identifier, :path, :file

    def self.identifier(input)
      input.gsub(PATH_SEPARATOR, IDENTIFIER_SEPARATOR)
    end

    def self.path(input)
      input.gsub(IDENTIFIER_SEPARATOR, PATH_SEPARATOR)
    end

    def initialize(identifier, path)
      @identifier = identifier
      @path = path
      @file = "#{path}.rb"
    end

    def name
      Inflecto.camelize(path)
    end

    def constant
      Inflecto.constantize(name)
    end

    def instance(*args)
      constant.new(*args)
    end
  end
end
