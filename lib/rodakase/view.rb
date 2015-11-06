module Rodakase
  class View
    extend Dry::Configurable

    class Scope
      attr_reader :part

      def initialize(part)
        @part = part
      end

      def method_missing(name, *args, &block)
        if part[name]
          part[name]
        elsif part.respond_to?(name)
          part.public_send(name, *args, &block)
        else
          super
        end
      end
    end

    class Part
      attr_reader :renderer, :config, :data

      alias_method :value, :data

      def initialize(renderer, config, data)
        @renderer = renderer
        @config = config
        @data = data
      end

      def to_s
        value
      end

      def [](name)
        data[name]
      end

      def each(&block)
        data.values[0].each(&block)
      end

      def render(path)
        renderer.(path, Scope.new(data))
      end

      def template(name)
        "#{config.template}/#{name}.#{config.engine}"
      end

      def template?(name)
        File.exist?(renderer.root.join(template("_#{name}")))
      end

      def respond_to_missing?(name, include_private = false)
        super || data.key?(name) || template?(name)
      end

      def method_missing(name, *args, &block)
        if template?(name)
          render(template("_#{name}"))
        elsif data.key?(name)
          data[name]
        else
          super
        end
      end
    end

    setting :engine
    setting :renderer
    setting :layout
    setting :template

    attr_reader :config, :renderer, :template, :layout

    def initialize
      @config = self.class.config
      @renderer = @config.renderer.()
      @layout = "layouts/#{config.layout}.#{config.engine}"
      @template = "#{config.template}.#{config.engine}"
    end

    def call(scope, locals = {})
      renderer.(layout, scope) do
        render(Scope.new(parts(locals)))
      end
    end

    def render(locals = {})
      renderer.(template, Scope.new(locals))
    end

    def parts(locals)
      locals.each_with_object({}) do |(key, value), result|
        part =
          case value
          when Array
            part(key => value.map { |element| part(element) })
          when Hash
            part(value)
          end

        result[key] = part
      end
    end

    def part(value)
      Part.new(renderer, config, value)
    end
  end
end
