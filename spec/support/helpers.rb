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

  def db_conn
    container['persistence.rom'].gateways[:default].connection
  end
end
