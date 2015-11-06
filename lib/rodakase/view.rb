module Rodakase
  class View
    class Scope
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def method_missing(name)
        data[name]
      end
    end

    extend Dry::Configurable

    setting :engine
    setting :layout
    setting :template

    attr_reader :config, :renderer, :template, :layout

    def initialize(renderer, config = self.class.config)
      @renderer = renderer
      @config = config
      @layout = "layouts/#{config.layout}.#{config.engine}"
      @template = "#{config.template}.#{config.engine}"
    end

    def call(scope, locals = {})
      renderer.(layout, scope) { render(locals) }
    end

    def render(locals = {})
      renderer.(template, Scope.new(locals))
    end
  end
end
