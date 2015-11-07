Dummy::Requests.define do |r|
  r.define('requests.users.create') do
    step 'transactions.register_user'
  end
end
