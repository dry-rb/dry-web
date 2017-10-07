require "hanami/cli/registry"

module Dry
  module Web
    class CLI
      module Commands
        extend Hanami::CLI::Registry

        require "dry/web/cli/command"
        require "dry/web/cli/commands/console"
      end
    end
  end
end
