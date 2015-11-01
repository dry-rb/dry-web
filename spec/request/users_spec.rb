RSpec.describe '/users', type: :request do
  it 'works' do
    get '/users'

    expect(last_response).to be_ok
    expect(last_response.body).to eql('hello')
  end
end
