module Persistence
  class UserRepo
    USERS = []

    def create(user)
      USERS << Entities::User.new(*user.values)
    end
  end
end
