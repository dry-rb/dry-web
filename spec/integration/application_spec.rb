RSpec.describe 'Rodakase Application' do
  it 'loads container' do
    expect(Dummy[:logger]).to be_instance_of(Logger)
  end
end
