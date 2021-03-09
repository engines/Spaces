require_relative 'division'

module Commissioning
  class Container < ::Divisions::Container
    include ::Commissioning::Division

  end
end
