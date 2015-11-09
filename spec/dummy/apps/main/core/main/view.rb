require 'main/container'
require 'rodakase/view'

module Main
  class Page
    def title
      'Woohaa'
    end
  end
end

module Main
  class View < Rodakase::View::Layout
    setting :root, Container.root.join('templates')
    setting :scope, Page.new
    setting :engine, :slim
    setting :name, 'app'
  end
end
