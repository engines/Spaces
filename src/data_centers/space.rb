require_relative '../defaultables/space'
require_relative 'data_center'

module DataCenters
  class Space < ::Defaultables::Space

    def default_model_class
      DataCenter
    end

  end
end
