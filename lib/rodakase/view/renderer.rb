require 'tilt'

module Rodakase
  module View
    class Renderer
      attr_reader :root, :engine

      def initialize(root, engine = nil)
        @root = root
        @engine = engine
      end

      def call(template, scope, &block)
        Tilt.new(root.join("#{template}.#{engine}")).render(scope, &block)
      end

      def chdir(dirname)
        self.class.new(root.join(dirname), engine)
      end

      def template?(name)
        File.exist?(root.join("#{name}.#{engine}"))
      end
    end
  end
end
