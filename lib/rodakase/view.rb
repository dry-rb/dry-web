module Rodakase
  class View
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

    def call(locals = {})
      renderer.(layout) { render(locals) }
    end

    def render(locals = {})
      renderer.(template, locals)
    end
  end
end
