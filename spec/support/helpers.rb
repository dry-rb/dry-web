module Helpers
  module_function

  def fixtures_path
    SPEC_ROOT.join('fixtures')
  end

  def container
    Dummy::Application
  end

  def app
    Dummy::Application.app
  end

  def db_conn
    container['persistence.rom'].gateways[:default].connection
  end
end
