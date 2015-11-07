require 'tilt'

module Rodakase
  module View
    class Renderer
      attr_reader :root

      def initialize(root)
        @root = root
      end

      def call(template, scope, &block)
        Tilt.new(root.join(template)).render(scope, &block)
      end
    end
  end
end
