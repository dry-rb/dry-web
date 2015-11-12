require 'dry-configurable'
require 'dry-equalizer'

require 'rodakase/view/part'

module Rodakase
  module View
    class Layout
      include Dry::Equalizer(:config)

      Scope = Struct.new(:page)
      DEFAULT_SCOPE = Object.new.freeze

      extend Dry::Configurable

      setting :engine
      setting :renderer
      setting :name
      setting :template

      def self.configure(&block)
        super do |config|
          yield(config)

          unless config.renderer
            config.renderer = Renderer.new(config.root, engine: config.engine)
          end
        end
      end

      attr_reader :config, :renderer, :scope,
        :layout_dir, :layout_path, :template_path

      def initialize
        @config = self.class.config
        @renderer = @config.renderer
        @layout_dir = "layouts"
        @layout_path = "#{layout_dir}/#{config.name}"
        @template_path = config.template
        @scope = config.scope
      end

      def call(options = {})
        renderer.(layout_path, layout_scope(options)) do
          renderer.(template_path, template_scope(options))
        end
      end

      def layout_scope(options)
        Scope.new(layout_part(:page, options.fetch(:scope, scope)))
      end

      def template_scope(options)
        parts(locals(options))
      end

      def locals(options)
        options.fetch(:locals, {})
      end

      def parts(locals)
        return DEFAULT_SCOPE unless locals.any?

        locals.each_with_object({}) do |(key, value), result|
          part =
            case value
            when Array
              el_key = Inflecto.singularize(key).to_sym
              template_part(key, value.map { |element| template_part(el_key, element) })
            else
              template_part(key, value)
            end

          result[key] = part
        end.reduce(method(:template_part)) do |part, (key, value)|
          part.(key, value)
        end
      end

      def layout_part(name, value)
        part(layout_dir, name, value)
      end

      def template_part(name, value)
        part(template_path, name, value)
      end

      def part(dir, name, value)
        Part.new(renderer.chdir(dir), name => value)
      end
    end
  end
end
