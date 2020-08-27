require_relative '../releases/component'
require_relative '../defaultables/defaultable'

module DataCenters
  class DataCenter < ::Releases::Component
    include Defaultables::Defaultable

  end
end
