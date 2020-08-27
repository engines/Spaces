require_relative '../spaces/space'
require_relative '../defaultables/space'
require_relative 'data_center'

module DataCenters
  class Space < ::Spaces::Space
    include Defaultables::Space

    def default_model_class
      DataCenter
    end

  end
end
