require 'entities/user'

module Persistence
  module Repositories
    class Users < ROM::Repository
      relations :users

      def all
        users.as(Entities::User).to_a
      end
    end
  end
end
