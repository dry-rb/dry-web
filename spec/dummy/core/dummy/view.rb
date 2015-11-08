require 'rodakase/view'

module Dummy
  class View < Rodakase::View::Layout
    setting :renderer, -> engine { Dummy::Container[:renderer].(engine) }
    setting :engine, :slim
    setting :name, 'app'
  end
end
