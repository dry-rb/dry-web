require 'dry-equalizer'

require 'rodakase/view/renderer'
require 'rodakase/view/part'
require 'rodakase/view/null_part'

module Rodakase
  module View
    class RenderContext
      include Dry::Equalizer(:view, :renderer, :options)

      Scope = Struct.new(:page)

      attr_reader :view, :renderer, :options

      def initialize(view, format, engine, options = {})
        @view = view
        @renderer = Renderer.new(view.config.root, format: format, engine: engine)
        @options = options
      end

      def render
        renderer.(view.layout_path, layout_scope) do
          renderer.(view.template_path, template_scope)
        end
      end

      def parts(locals)
        part_hash = locals.each_with_object({}) do |(key, value), result|
          part =
            case value
            when Array
              el_key = Inflecto.singularize(key).to_sym
              template_part(key, value.map { |element| template_part(el_key, element) })
            else
              template_part(key, value)
            end

          result[key] = part
        end

        part(view.template_path, part_hash)
      end

      private

      def layout_scope
        Scope.new(layout_part(:page, options.fetch(:scope, view.scope)))
      end

      def template_scope
        parts(view.locals(options))
      end

      def layout_part(name, value)
        part(view.layout_dir, name => value)
      end

      def template_part(name, value)
        part(view.template_path, name => value)
      end

      def part(dir, value)
        value_present = value.values.first
        part_class = value_present ? Part : NullPart

        part_class.new(renderer.chdir(dir), value)
      end
    end
  end
end
