require "dry/web/settings/file_parser"

module Dry
  module Web
    class Settings
      class FileLoader
        def call(root, env)
          files(root, env).reduce({}) do |hash, file|
            hash.merge(parser.(file))
          end
        end

        private

        def parser
          @parser ||= FileParser.new
        end

        def files(root, env)
          [
            root.join(".env"),
            root.join(".env.#{env}")
          ].compact
        end
      end
    end
  end
end
