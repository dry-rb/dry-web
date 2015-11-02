require 'tilt'

module Rodakase
  class Renderer
    class Locals
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def method_missing(name)
        data[name]
      end
    end

    attr_reader :root

    def initialize(root)
      @root = root
    end

    def call(template, locals)
      Tilt.new(root.join(template)).render(Locals.new(locals))
    end
  end
end
