require_relative '../emitting/emissions/division'
require_relative '../defaultables/defaultable'

module Clients
  class Client < ::Emitting::Division
    include Defaultables::Defaultable

  end
end
