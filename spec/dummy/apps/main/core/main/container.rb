module Main
  class Container < Dummy::Container
    setting :root, Pathname(__FILE__).join('../..').realpath.dirname.freeze
    setting :auto_load, 'lib'

    load_paths!('lib')
  end
end
