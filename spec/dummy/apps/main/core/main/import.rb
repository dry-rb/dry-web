require_relative 'container'

module Main
  Import = Main::Container.import_module

  def self.Import(*args)
    Import[*args]
  end
end
