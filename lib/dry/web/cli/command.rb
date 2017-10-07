require "hanami/cli/command"

module Dry
  module Web
    class CLI
      class Command < Hanami::CLI::Command
        attr_reader :application

        def initialize(application: nil, **args)
          @application = application
          super(args)
        end

        def with(**new_options)
          self.class.new(new_options.merge(command_name: command_name))
        end
      end
    end
  end
end
