module Helpers
  module_function

  def fixtures_path
    SPEC_ROOT.join('fixtures')
  end

  def container
    Dummy::Container
  end

  def app
    Main::Application.app
  end
end
