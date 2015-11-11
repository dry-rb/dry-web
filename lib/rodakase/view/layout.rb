require 'dry-configurable'
require 'equalizer'

require 'rodakase/view/part'

module Rodakase
  module View
    class Layout
      include Equalizer.new(:config)

      Scope = Struct.new(:page)

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
        layout_scope = Scope.new(
          Part.new(renderer.chdir('layouts'), page: options.fetch(:scope, scope))
        )

        renderer.(path, layout_scope) do
          template_scope = parts(locals(options))
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
