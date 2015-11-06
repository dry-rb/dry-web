require 'rodakase/view'

RSpec.describe 'Rodakase View' do
  let(:view_class) do
    Class.new(Rodakase::View) do
      configure do |config|
        config.engine = :slim
        config.layout = 'app'
        config.template = 'users'
      end
    end
  end

  let(:renderer) do
    Class.new(Rodakase::Renderer).new(SPEC_ROOT.join('fixtures/templates'))
  end

  let(:scope) do
    Struct.new(:title).new('Rodakase Rocks!')
  end

  it 'renders within a layout using provided scope' do
    view = view_class.new(renderer)

    expect(view.(scope, users: %w(jane joe))).to eql(
      '<!DOCTYPE html><html><head><title>Rodakase Rocks!</title></head><body><ul><li>jane</li><li>joe</li></ul></body></html>'
    )
  end
end
