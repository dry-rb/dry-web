require 'dummy/import'

module Main
  def self.Import(*args)
    Dummy::Import[*args]
  end
end
