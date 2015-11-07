module Rodakase
  module View
    class Scope
      attr_reader :part

      def initialize(part)
        @part = part
      end

      def method_missing(name, *args, &block)
        if part[name]
          part[name]
        elsif part.respond_to?(name)
          part.public_send(name, *args, &block)
        else
          super
        end
      end
    end
  end
end
