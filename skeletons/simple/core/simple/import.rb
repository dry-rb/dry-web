require_relative 'container'

module Simple
  Import = Container.import_module

  def self.Import(*args)
    Import[*args]
  end
end
