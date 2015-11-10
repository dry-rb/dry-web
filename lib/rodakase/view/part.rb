module Rodakase
  module View
    class Part
      attr_reader :renderer, :_name, :_data, :_scope, :_value

      def initialize(renderer, name, data, scope)
        @renderer = renderer
        @_name = name
        @_data = data
        @_value = data.values[0]
        @_scope = scope
      end

      def [](key)
        _value[key]
      end

      def each(&block)
        _value.each(&block)
      end

      def render(path, &block)
        renderer.render(path, _scope, &block)
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
        elsif _value.key?(meth)
          _value[meth]
        else
          super
        end
      end
    end
  end
end
