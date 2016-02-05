require 'dry-equalizer'

module Rodakase
  module View
    class Part
      include Dry::Equalizer(:renderer)

      attr_reader :renderer

      def initialize(renderer)
        @renderer = renderer
      end

      def render(path, &block)
        renderer.render(path, self, &block)
      end

      def template?(name)
        renderer.lookup("_#{name}")
      end

      def respond_to_missing?(meth, include_private = false)
        super || template?(meth)
      end

      private

      def method_missing(meth, *args, &block)
        template_path = template?(meth)

        if template_path
          render(template_path, &block)
        else
          super
        end
      end
    end
  end
end
