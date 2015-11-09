require 'dummy/container'
require 'rodakase/view'

module Dummy
  class Page
    def title
      'Woohaa'
    end
  end
end

module Dummy
  class View < Rodakase::View::Layout
    setting :root, Container.root.join('templates')
    setting :scope, Page.new
    setting :engine, :slim
    setting :name, 'app'
  end
end
