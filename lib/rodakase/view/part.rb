module Rodakase
  module View
    class Part
      attr_reader :renderer, :_data, :_value

      def initialize(renderer, data)
        @renderer = renderer
        @_data = data
        @_value = data.values[0]
      end

      def [](key)
        _value[key]
      end

      def each(&block)
        _value.each(&block)
      end

      def render(path, &block)
        renderer.render(path, self, &block)
      end

      def template?(name)
        renderer.lookup("_#{name}")
      end

      def respond_to_missing?(meth, include_private = false)
        super || _data.key?(meth) || template?(meth)
      end

      private

      def method_missing(meth, *args, &block)
        template_path = template?(meth)

        if template_path
          render(template_path, &block)
        elsif _data.key?(meth)
          _data[meth]
        elsif _value.respond_to?(meth)
          _value.public_send(meth, *args, &block)
        else
          super
        end
      end
    end
  end
end
