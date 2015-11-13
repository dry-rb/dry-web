require 'web_helper'

RSpec.describe '/hearbeat', type: :request do
  it 'works' do
    get '/heartbeat'

    expect(last_response).to be_ok
  end
end
