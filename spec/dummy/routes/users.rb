class Dummy < Rodakase::Application
  route('users') do |r|
    r.get { 'hello' }
  end
end
