require "hanami/cli"

module Dry
  module Web
    class CLI < Hanami::CLI
      require "dry/web/cli/commands"

      def self.register(name, command = nil, aliases: [], &blk)
        Commands.register(name, command, aliases: aliases, &blk)
      end

      attr_reader :application

      def initialize(registry, application = nil)
        super(registry)
        @application = application
      end

      private

      # TODO: this is not a great thing to have to do, to override parse? It's a private method from the superclass?
      def parse(result, out)
        command, arguments = super
        command = command.with(application: application) if application
        [command, arguments]
      end
    end
  end
end
