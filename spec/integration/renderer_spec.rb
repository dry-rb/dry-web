require 'rodakase/renderer'

RSpec.describe 'Rodakase Renderer' do
  subject(:renderer) { Rodakase::Renderer.new(fixtures_path.join('templates')) }

  it 'renders a given template' do
    output = renderer.call('users.slim', users: %w(jane joe))

    expect(output).to eql('<ul><li>jane</li><li>joe</li></ul>')
  end
end
