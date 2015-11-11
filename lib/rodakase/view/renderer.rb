require 'tilt'
require 'equalizer'

module Rodakase
  module View
    class Renderer
      include Equalizer.new(:dir, :root, :engine)

      TemplateNotFoundError = Class.new(StandardError)

      attr_reader :dir, :root, :engine, :tilts

      def self.tilts
        @__engines__ ||= {}
      end

      def initialize(dir, options = {})
        @dir = dir
        @root = options.fetch(:root, dir)
        @engine = options[:engine]
        @tilts = self.class.tilts
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
        tilt(path).render(scope, &block)
      end

      def tilt(path)
        tilts.fetch(path) { tilts[path] = Tilt[engine].new(path) }
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
