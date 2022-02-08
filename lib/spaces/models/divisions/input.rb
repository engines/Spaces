require_relative 'struct_can_respond'

module Divisions
  class Input < ::Divisions::Division
    include StructCanRespond

  end
end
