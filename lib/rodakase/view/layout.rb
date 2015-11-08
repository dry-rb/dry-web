require 'dry-configurable'

require 'rodakase/view/scope'
require 'rodakase/view/part'

module Rodakase
  module View
    class Layout
      extend Dry::Configurable

      setting :engine
      setting :renderer
      setting :name
      setting :template

      attr_reader :config, :renderer, :template, :name

      def initialize
        @config = self.class.config
        @renderer = @config.renderer.()
        @name = "layouts/#{config.name}.#{config.engine}"
        @template = "#{config.template}.#{config.engine}"
      end

      def call(scope, options = {})
        renderer.(name, scope) do
          render(Scope.new(parts(locals(options))))
        end
      end

      def locals(options)
        options.fetch(:locals, {})
      end

      def render(locals = {})
        renderer.(template, Scope.new(locals))
      end

      def parts(locals)
        locals.each_with_object({}) do |(key, value), result|
          part =
            case value
            when Array
              el_key = Inflecto.singularize(key).to_sym
              part(key => value.map { |element| part(el_key => element) })
            end

          result[key] = part
        end
      end

      def part(value)
        Part.new(renderer, config, value)
      end
    end
  end
end
