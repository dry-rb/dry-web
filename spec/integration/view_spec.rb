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

  it 'renders within a layout' do
    view = view_class.new(renderer)

    expect(view.(users: %w(jane joe))).to eql(
      '<!DOCTYPE html><html><head><title>Testing</title></head><body><ul><li>jane</li><li>joe</li></ul></body></html>'
    )
  end
end
