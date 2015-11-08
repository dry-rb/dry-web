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

      attr_reader :config, :renderer, :path, :template, :partial_dirname

      def initialize
        @config = self.class.config
        @renderer = @config.renderer.(config.engine)
        @path = "layouts/#{config.name}"
        @template = "#{config.template}"
        @partial_dirname = config.template
      end

      def call(scope, options = {})
        renderer.(path, scope) do
          template_scope = Scope.new(parts(locals(options)))
          renderer.(template, template_scope)
        end
      end

      def locals(options)
        options.fetch(:locals, {})
      end

      def parts(locals)
        locals.each_with_object({}) do |(key, value), result|
          el_key = Inflecto.singularize(key).to_sym

          part =
            case value
            when Array
              part(key, key => value.map { |element| part(el_key, el_key => element) })
            else
              part(el_key, el_key => value)
            end

          result[key] = part
        end
      end

      def part(name, value)
        Part.new(renderer.chdir(partial_dirname), name, value, Scope.new(value))
      end
    end
  end
end
