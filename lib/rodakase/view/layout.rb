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

      setting :root
      setting :name
      setting :template
      setting :formats
      setting :scope

      attr_reader :config, :scope, :layout_dir, :layout_path, :template_path

      def self.renderer(format = nil)
        format = config.formats.keys.first unless format
        raise ArgumentError, "format +#{format}+ is not configured" unless config.formats.keys.include?(format.to_sym)

        @renderers ||= Hash.new do |h, key|
          h[key.to_sym] = Renderer.new(config.root, format: key, engine: config.formats[key.to_sym])
        end
        @renderers[format]
      end

      def initialize
        @config = self.class.config
        @layout_dir = DEFAULT_DIR
        @layout_path = "#{layout_dir}/#{config.name}"
        @template_path = config.template
        @scope = config.scope
      end

      def call(options = {})
        renderer = self.class.renderer(options[:format])

        renderer.(layout_path, layout_scope(options, renderer)) do
          renderer.(template_path, template_scope(options))
        end
      end

      def locals(options)
        options.fetch(:locals, {})
      end

      def parts(locals, options = {})
        renderer = self.class.renderer(options[:format])

        return DEFAULT_SCOPE unless locals.any?

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

      def template_scope(options)
        parts(locals(options), options)
      end

      def layout_part(name, renderer, value)
        part(layout_dir, renderer, { name => value })
      end

      def template_part(name, renderer, value)
        part(template_path, renderer, { name => value })
      end

      def part(dir, renderer, value = {})
        part_class = value.values[0] ? Part : NullPart
        part_class.new(renderer.chdir(dir), value)
      end
    end
  end
end
