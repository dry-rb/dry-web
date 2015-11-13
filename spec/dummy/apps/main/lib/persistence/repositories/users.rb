require 'main/import'
require 'entities/user'

module Persistence
  module Repositories
    class Users
      include Main::Import(:db)

      def all
        db[:users]
      end
    end
  end
end
