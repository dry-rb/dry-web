require 'rodakase/view'

module Dummy
  class View < Rodakase::View::Layout
    setting :renderer, -> { Dummy::Container[:renderer] }
    setting :engine, :slim
    setting :layout, 'app'
  end
end
