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

      attr_reader :config, :renderer, :scope, :path, :template, :partial_dirname

      def initialize
        @config = self.class.config
        @renderer = @config.renderer
        @path = "layouts/#{config.name}"
        @template = "#{config.template}"
        @partial_dirname = config.template
        @scope = config.scope
      end

      def call(options = {})
        renderer.(path, layout_scope(options)) do
          renderer.(template, template_scope(options))
        end
      end

      def layout_scope(options)
        Scope.new(
          Part.new(renderer.chdir('layouts'), page: options.fetch(:scope, scope))
        )
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
          el_key = Inflecto.singularize(key).to_sym

          part =
            case value
            when Array
              part(key, value.map { |element| part(el_key, element) })
            else
              part(el_key, value)
            end

          result[key] = part
        end.reduce(method(:part)) do |part, (key, value)|
          part.(key, value)
        end
      end

      def part(name, value)
        Part.new(renderer.chdir(partial_dirname), name => value)
      end
    end
  end
end
