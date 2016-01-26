require 'dry-configurable'
require 'dry-equalizer'

require 'rodakase/view/part'
require 'rodakase/view/null_part'
require 'rodakase/view/renderer'

module Rodakase
  module View
    class Layout
      include Dry::Equalizer(:config)

      Scope = Struct.new(:page)

      DEFAULT_SCOPE = Object.new.freeze
      DEFAULT_DIR = 'layouts'.freeze

      extend Dry::Configurable

      setting :engine
      setting :root
      setting :name
      setting :template
      setting :default_format, 'html'
      setting :scope

      attr_reader :config, :scope,
        :layout_dir, :layout_path, :template_path

      def initialize
        @config = self.class.config
        @layout_dir = DEFAULT_DIR
        @layout_path = "#{layout_dir}/#{config.name}"
        @template_path = config.template
        @scope = config.scope
      end

      def call(options = {})
        renderer = Renderer.new(config.root, format: options.fetch(:format, config.default_format), engine: config.engine)

        renderer.(layout_path, layout_scope(options, renderer)) do
          renderer.(template_path, template_scope(options, renderer))
        end
      end

      def format(new_format)
        return self if format == new_format
        self.class.new(new_format)
      end

      def layout_scope(options, renderer)
        Scope.new(layout_part(:page, options.fetch(:scope, scope), renderer))
      end

      def template_scope(options, renderer)
        parts(locals(options), renderer)
      end

      def locals(options)
        options.fetch(:locals, {})
      end

      def parts(locals, renderer)
        return DEFAULT_SCOPE unless locals.any?

        part_hash = locals.each_with_object({}) do |(key, value), result|
          part =
            case value
            when Array
              el_key = Inflecto.singularize(key).to_sym
              template_part(key, value.map { |element| template_part(el_key, element, renderer) }, renderer)
            else
              template_part(key, value, renderer)
            end

          result[key] = part
        end

        part(template_path, part_hash, renderer)
      end

      def layout_part(name, value, renderer)
        part(layout_dir, {name => value}, renderer)
      end

      def template_part(name, value, renderer)
        part(template_path, {name => value}, renderer)
      end

      def part(dir, value, renderer)
        value_present = value.values.first
        part_class = value_present ? Part : NullPart

        part_class.new(renderer.chdir(dir), value)
      end
    end
  end
end
