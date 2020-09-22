require_relative '../../../spaces/defaultables/defaultable'
require_relative '../../../emitting/emissions/division'

module Clients
  class Client < ::Emitting::Division
    include Defaultables::Defaultable

  end
end
