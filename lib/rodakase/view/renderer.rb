require 'tilt'

module Rodakase
  module View
    class Renderer
      TemplateNotFoundError = Class.new(StandardError)

      attr_reader :dir, :root, :engine

      def initialize(dir, options = {})
        @dir = dir
        @root = options.fetch(:root, dir)
        @engine = options[:engine]
      end

      def call(template, scope, &block)
        path = lookup(template)

        if path
          render(path, scope, &block)
        else
          raise TemplateNotFoundError, "Template #{template} could not be looked up within #{root}"
        end
      end

      def render(path, scope, &block)
        Tilt.new(path).render(scope, &block)
      end

      def lookup(name)
        template?(name) || template?("shared/#{name}") || !root? && chdir('..').lookup(name)
      end

      def root?
        dir == root
      end

      def template?(name)
        template_path = path(name)

        if File.exist?(template_path)
          template_path
        end
      end

      def path(name)
        dir.join("#{name}.#{engine}")
      end

      def chdir(dirname)
        self.class.new(dir.join(dirname), engine: engine, root: root)
      end
    end
  end
end
