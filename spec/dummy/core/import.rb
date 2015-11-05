require_relative 'container'

module Dummy
  Import = Dummy::Container.import_module

  def self.Import(*args)
    Import[*args]
  end
end

Dummy::Container.finalize!
