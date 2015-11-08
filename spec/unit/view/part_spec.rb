require 'rodakase/view/part'

RSpec.describe Rodakase::View::Part do
  subject(:part) do
    Rodakase::View::Part.new(renderer, name, data, scope)
  end

  let(:name) { :user }
  let(:data) { { user: { email: 'jane@doe.org' } } }
  let(:scope) { double(:scope) }

  let(:renderer) { double(:renderer) }

  describe '#[]' do
    it 'gives access to data values' do
      expect(part[:email]).to eql('jane@doe.org')
    end
  end

  describe '#render' do
    it 'renders given template' do
      expect(renderer).to receive(:call).with('_row', scope)

      part.render('row')
    end
  end

  describe '#template?' do
    it 'asks renderer if there is a valid template for a given identifier' do
      expect(renderer).to receive(:template?).with('_row').and_return(true)

      expect(part.template?('row')).to be(true)
    end
  end
end
