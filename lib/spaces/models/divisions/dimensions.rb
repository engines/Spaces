require_relative 'struct_can_respond'

module Divisions
  class Dimensions < ::Divisions::Division
    include StructCanRespond
  end
end
