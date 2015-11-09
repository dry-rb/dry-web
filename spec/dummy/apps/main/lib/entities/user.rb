require 'dry/data'

module Entities
  class User < Dry::Data::Struct
    include Equalizer.new(:id, :name)

    attribute :id, 'int'
    attribute :name, 'string'
  end
end
