require 'rodakase/view/part'

RSpec.describe Rodakase::View::Part do
  subject(:part) do
    Rodakase::View::Part.new(renderer, data)
  end

  let(:name) { :user }
  let(:data) { { user: { email: 'jane@doe.org' } } }

  let(:renderer) { double(:renderer) }

  describe '#[]' do
    it 'gives access to data values' do
      expect(part[:email]).to eql('jane@doe.org')
    end
  end

  describe '#render' do
    it 'renders given template' do
      expect(renderer).to receive(:render).with('row.slim', part)

      part.render('row.slim')
    end
  end

  describe '#template?' do
    it 'asks renderer if there is a valid template for a given identifier' do
      expect(renderer).to receive(:lookup).with('_row').and_return('row.slim')

      expect(part.template?('row')).to eql('row.slim')
    end
  end

  describe '#method_missing' do
    it 'renders template' do
      expect(renderer).to receive(:lookup).with('_row').and_return('_row.slim')
      expect(renderer).to receive(:render).with('_row.slim', part)

      part.row
    end

    it 'renders template within another when block is passed' do
      block = proc { part.fields }

      expect(renderer).to receive(:lookup).with('_form').and_return('form.slim')
      expect(renderer).to receive(:lookup).with('_fields').and_return('fields.slim')

      expect(renderer).to receive(:render).with('form.slim', part, &block)
      expect(renderer).to receive(:render).with('fields.slim', part)

      part.form(block)
    end
  end
end
