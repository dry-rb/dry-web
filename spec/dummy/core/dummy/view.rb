require 'dummy/container'
require 'rodakase/view'

module Dummy
  class View < Rodakase::View::Layout
    setting :root, Container.root.join('templates')
    setting :engine, :slim
    setting :name, 'app'
  end
end
