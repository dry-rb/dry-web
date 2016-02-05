require 'dry-equalizer'
require 'rodakase/view/part'

module Rodakase
  module View
    class ValuePart < Part
      include Dry::Equalizer(:renderer, :_data, :_value)

      attr_reader :_data, :_value

      def initialize(renderer, data)
        super(renderer)
        @_data = data
        @_value = data.values[0]
      end

      def to_s
        _value.to_s
      end

      def [](key)
        _value[key]
      end

      def each(&block)
        _value.each(&block)
      end

      def respond_to_missing?(meth, include_private = false)
        _data.key?(meth) || super
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
