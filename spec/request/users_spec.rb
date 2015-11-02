RSpec.describe '/users', type: :request do
  describe 'GET /users' do
    it 'renders hello template' do
      get '/users'

      expect(last_response).to be_ok
      expect(last_response.body).to eql('<h1>Hello World</h1>')
    end
  end

  describe 'POST /users' do
    it 'creates a user' do
      user = { id: '1', name: 'Jane' }

      post '/users', user: user

      expect(last_response).to be_created

      expect(Persistence::UserRepo::USERS).to include(Entities::User.new(*user.values))
    end
  end
end
