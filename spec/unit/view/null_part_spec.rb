require 'rodakase/view/null_part'

RSpec.describe Rodakase::View::NullPart do
  subject(:part) do
    Rodakase::View::NullPart.new(renderer, data)
  end

  let(:name) { :user }
  let(:data) { { user: nil } }

  let(:renderer) { double(:renderer) }

  describe '#[]' do
    it 'returns nil for any data value names' do
      expect(part[:email]).to eql(nil)
    end
  end

  describe '#method_missing' do
    it 'renders a template with the _missing suffix' do
      expect(renderer).to receive(:lookup).with('_row_missing').and_return('_row_missing.slim')
      expect(renderer).to receive(:render).with('_row_missing.slim', part)

      part.row
    end

    it 'renders a _missing template within another when block is passed' do
      block = proc { part.fields }

      expect(renderer).to receive(:lookup).with('_form_missing').and_return('form_missing.slim')
      expect(renderer).to receive(:lookup).with('_fields_missing').and_return('fields_missing.slim')

      expect(renderer).to receive(:render).with('form_missing.slim', part, &block)
      expect(renderer).to receive(:render).with('fields_missing.slim', part)

      part.form(block)
    end
  end
end
