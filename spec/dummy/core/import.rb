require_relative 'container'

module Dummy
  Import = Dummy::Container.import

  def self.Import(*args)
    Import[*args]
  end
end
