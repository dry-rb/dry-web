require 'slim'
require 'dry-view'

require_relative 'container'

module Main
  class Page
    def title
      'Woohaa'
    end
  end
end

module Main
  class View < Dry::View::Layout
    setting :root, Container.root.join('web/templates')
    setting :scope, Page.new
    setting :formats, {html: :slim}
    setting :name, 'app'.freeze
  end
end
