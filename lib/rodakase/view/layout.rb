require 'dry-configurable'
require 'dry-equalizer'

require 'rodakase/view/part'
require 'rodakase/view/value_part'
require 'rodakase/view/null_part'
require 'rodakase/view/renderer'

module Rodakase
  module View
    class Layout
      include Dry::Equalizer(:config)

      Scope = Struct.new(:page)

      DEFAULT_DIR = 'layouts'.freeze

      extend Dry::Configurable

      setting :root
      setting :name
      setting :template
      setting :formats, { html: :erb }
      setting :scope

      attr_reader :config, :scope, :layout_dir, :layout_path, :template_path,
        :default_format

      def self.renderer(format = default_format)
        unless config.formats.key?(format.to_sym)
          raise ArgumentError, "format +#{format}+ is not configured"
        end

        renderers[format]
      end

      def self.renderers
        @renderers ||= Hash.new do |h, key|
          h[key.to_sym] = Renderer.new(
            config.root, format: key, engine: config.formats[key.to_sym]
          )
        end
      end

      def self.default_format
        config.formats.keys.first
      end

      def initialize
        @config = self.class.config
        @default_format = self.class.default_format
        @layout_dir = DEFAULT_DIR
        @layout_path = "#{layout_dir}/#{config.name}"
        @template_path = config.template
        @scope = config.scope
      end

      def call(options = {})
        renderer = self.class.renderer(options.fetch(:format, default_format))

        template_content = renderer.(template_path, template_scope(options, renderer))

        renderer.(layout_path, layout_scope(options, renderer)) do
          template_content
        end
      end

      def locals(options)
        options.fetch(:locals, {})
      end

      def parts(locals, renderer)
        return empty_part(template_path, renderer) unless locals.any?

        part_hash = locals.each_with_object({}) do |(key, value), result|
          part =
            case value
            when Array
              el_key = Inflecto.singularize(key).to_sym

              template_part(
                key, renderer,
                value.map { |element| template_part(el_key, renderer, element) }
              )
            else
              template_part(key, renderer, value)
            end

          result[key] = part
        end

        part(template_path, renderer, part_hash)
      end

      private

      def layout_scope(options, renderer)
        Scope.new(layout_part(:page, renderer, options.fetch(:scope, scope)))
      end

      def template_scope(options, renderer)
        parts(locals(options), renderer)
      end

      def layout_part(name, renderer, value)
        part(layout_dir, renderer, { name => value })
      end

      def template_part(name, renderer, value)
        part(template_path, renderer, { name => value })
      end

      def part(dir, renderer, value = {})
        part_class = value.values[0] ? ValuePart : NullPart
        part_class.new(renderer.chdir(dir), value)
      end

      def empty_part(dir, renderer)
        Part.new(renderer.chdir(dir))
      end
    end
  end
end
