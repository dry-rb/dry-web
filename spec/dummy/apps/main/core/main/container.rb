module Main
  class Container < Dummy::Container
    setting :root, Pathname(__FILE__).join('../..').realpath.dirname.freeze
    setting :auto_register, 'lib'

    load_paths!('lib')
  end
end
