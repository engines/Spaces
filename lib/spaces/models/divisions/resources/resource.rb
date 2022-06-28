module Divisions
  class Resource < ::Divisions::Subdivision

    def identifier
      struct.identifier || struct.type
    end

    def configuration
      struct.configuration
    end

    #FIX: Resources are masquerading as adapters in artifact stanza processing
    def adapter_keys; [] ;end

  end
end
