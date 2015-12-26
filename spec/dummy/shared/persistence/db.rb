module Persistence
  class Db
    STORE = Hash.new { |k, v| k[v] = [] }

    def [](name)
      STORE[name]
    end
  end
end
