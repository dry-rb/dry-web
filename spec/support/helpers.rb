module Helpers
  def fixtures_path
    SPEC_ROOT.join('fixtures')
  end

  def app
    Dummy::Application.app
  end
end
