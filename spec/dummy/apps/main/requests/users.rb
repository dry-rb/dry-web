Main::Requests.define do |r|
  r.define('main.requests.users.create') do
    step 'main.transactions.register_user'
  end
end
