require 'main/import'
require 'main/entities/user'

module Main
  module Persistence
    module Repositories
      class Users
        include Main::Import('persistence.db')

        def all
          db[:users]
        end
      end
    end
  end
end
