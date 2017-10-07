require "dry/web/console"

module Dry
  module Web
    class CLI
      module Commands
        class Console < Command
          desc "Starts dry-web application console"

          def call(**)
            Dry::Web::Console.start
          end
        end

        register "console", Console, aliases: ["c"]
      end
    end
  end
end
