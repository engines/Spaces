require_relative '../spaces/space'
require_relative '../defaultables/space'
require_relative 'client'

module Clients
  class Space < ::Spaces::Space
    include Defaultables::Space

    def default_model_class
      Client
    end

  end
end
