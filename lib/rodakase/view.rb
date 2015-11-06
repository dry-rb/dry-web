module Rodakase
  class View
    extend Dry::Configurable

    class Scope
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def method_missing(name)
        data[name]
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
      renderer.(layout, scope) { render(locals) }
    end

    def render(locals = {})
      renderer.(template, Scope.new(locals))
    end
  end
end
