require 'entities/user'

module Persistence
  class UserRepo < ROM::Repository
    relations :users

    def all
      users.as(Entities::User).to_a
    end
  end
end
