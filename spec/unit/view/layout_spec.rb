RSpec.describe Rodakase::View::Layout do
  subject(:layout) { layout_class.new }

  let(:layout_class) do
    klass = Class.new(Rodakase::View::Layout)

    klass.configure do |config|
      config.renderer = -> _engine { renderer }
      config.name = 'app'
      config.template = 'user'
      config.engine = 'slim'
    end

    klass
  end

  let(:renderer) do
    Rodakase::View::Renderer.new(SPEC_ROOT.join('fixtures/templates'), 'slim')
  end

  let(:scope) do
    double(:scope, title: 'Test')
  end

  let(:options) do
    { locals: { user: { name: 'Jane' } } }
  end

  describe '#call' do
    it 'renders template within the layout' do
      expect(layout.(scope, options)).to eql(
        '<!DOCTYPE html><html><head><title>Test</title></head><body><p>Jane</p></body></html>'
      )
    end
  end
end
