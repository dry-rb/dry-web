module Rodakase
  module View
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
  end
end
