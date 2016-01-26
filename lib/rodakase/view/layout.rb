require 'dry-configurable'
require 'dry-equalizer'

require 'rodakase/view/render_context'

module Rodakase
  module View
    class Layout
      include Dry::Equalizer(:config)

      DEFAULT_SCOPE = Object.new.freeze
      DEFAULT_DIR = 'layouts'.freeze

      extend Dry::Configurable

      setting :engine
      setting :root
      setting :name
      setting :template
      setting :format, 'html'
      setting :scope

      attr_reader :config, :layout_dir, :layout_path, :template_path

      def initialize
        @config = self.class.config
        @layout_dir = DEFAULT_DIR
        @layout_path = "#{layout_dir}/#{config.name}"
        @template_path = config.template
      end

      def call(options = {})
        render_context(options).render
      end

      def parts(locals, options = {})
        return DEFAULT_SCOPE unless locals.any?

        render_context(options).parts(locals)
      end

      def locals(options)
        options.fetch(:locals, {})
      end

      private

      def render_context(options)
        RenderContext.new(
          self,
          options.fetch(:scope, config.scope),
          options.fetch(:format, config.format),
          options.fetch(:engine, config.engine),
          options
        )
      end
    end
  end
end
