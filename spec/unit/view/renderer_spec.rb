require 'rodakase/view/renderer'

RSpec.describe Rodakase::View::Renderer do
  subject(:renderer) do
    Rodakase::View::Renderer.new(SPEC_ROOT.join('fixtures/templates'), format: 'html', engine: :slim)
  end

  let(:scope) { double(:scope) }

  describe '#call' do
    it 'renders template' do
      expect(renderer.('hello', scope)).to eql('<h1>Hello</h1>')
    end

    it 'looks up shared template in current dir' do
      expect(renderer.('_shared_hello', scope)).to eql('<h1>Hello</h1>')
    end

    it 'looks up shared template in upper dir' do
      expect(renderer.chdir('greetings').('_shared_hello', scope)).to eql('<h1>Hello</h1>')
    end

    it 'raises error when template was not found' do
      expect {
        renderer.('not_found', scope)
      }.to raise_error(Rodakase::View::Renderer::TemplateNotFoundError, /not_found/)
    end
  end
end
