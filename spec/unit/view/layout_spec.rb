RSpec.describe Rodakase::View::Layout do
  subject(:layout) { layout_class.new }

  let(:layout_class) do
    klass = Class.new(Rodakase::View::Layout)

    klass.configure do |config|
      config.root = SPEC_ROOT.join('fixtures/templates')
      config.name = 'app'
      config.template = 'user'
      config.formats = {html: :slim}
    end

    klass
  end

  let(:page) do
    double(:page, title: 'Test')
  end

  let(:options) do
    { scope: page, locals: { user: { name: 'Jane' }, header: { title: 'User' } } }
  end

  describe '#call' do
    it 'renders template within the layout' do
      expect(layout.(options)).to eql(
        '<!DOCTYPE html><html><head><title>Test</title></head><body><h1>User</h1><p>Jane</p></body></html>'
      )
    end
  end

  describe '#parts' do
    it 'returns view parts' do
      part = layout.parts(user: { id: 1, name: 'Jane' })

      expect(part[:id]).to be(1)
      expect(part[:name]).to eql('Jane')
    end

    it 'builds null parts for nil values' do
      part = layout.parts(user: nil)

      expect(part[:id]).to be_nil
    end

    it 'returns default scope when empty locals are passed' do
      expect(layout.parts({})).to be(layout.class::DEFAULT_SCOPE)
    end
  end
end
