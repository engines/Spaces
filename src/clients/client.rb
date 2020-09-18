require_relative '../releases/division'
require_relative '../defaultables/defaultable'

module Clients
  class Client < ::Releases::Division
    include Defaultables::Defaultable

  end
end
