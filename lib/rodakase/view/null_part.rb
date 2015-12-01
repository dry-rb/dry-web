require 'dry-equalizer'

module Rodakase
  module View
    class NullPart < Part
      def [](key);end
      def each(&block);end

      def respond_to_missing?(meth, include_private = false)
        true
      end

      private

      def method_missing(meth, *args, &block)
        template_path = template?("#{meth}_missing")

        if template_path
          render(template_path)
        else
          nil
        end
      end
    end
  end
end
