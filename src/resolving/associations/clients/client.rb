require_relative '../../../spaces/defaultables/defaultable'
require_relative '../../../emitting/emissions/division'

module Clients
  class Client < ::Emissions::Division
    include Defaultables::Defaultable

  end
end
