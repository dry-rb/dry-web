require 'rack'

require_relative 'dummy'
run Dummy.freeze.app
