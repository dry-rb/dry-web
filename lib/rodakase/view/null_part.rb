require 'dry-equalizer'

module Rodakase
  module View
    class NullPart
      def bind(&block);end
      def [](key);end
      def each(&block);end

      def render(path, &block)
        ''
      end

      def respond_to_missing?(meth, include_private = false)
        true
      end

      private

      def method_missing(meth, *args, &block)
        nil
      end
    end
  end
end
