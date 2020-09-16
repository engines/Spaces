require_relative '../releases/component'
require_relative '../defaultables/defaultable'

module Clients
  class Client < ::Releases::Component
    include Defaultables::Defaultable

  end
end
