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

      def render(name)
        renderer.("_#{name}", _scope)
      end

      def template?(name)
        renderer.template?("_#{name}")
      end

      def respond_to_missing?(name, include_private = false)
        super || _data.key?(name) || template?(name)
      end

      def method_missing(meth, *args, &block)
        if template?(meth)
          render(meth)
        elsif _value.key?(meth)
          _value[meth]
        else
          super
        end
      end
    end
  end
end
