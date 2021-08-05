module Arenas
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        about: struct.about,
        domain: struct.domain,
      ).compact
    end

  end
end
