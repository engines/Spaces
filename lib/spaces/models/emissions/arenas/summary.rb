module Arenas
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        input: struct.input,
        about: struct.about,
        domain: struct.domain,
      ).compact
    end

  end
end
