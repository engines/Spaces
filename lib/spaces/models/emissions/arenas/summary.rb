module Arenas
  module Summary

    def summary
      OpenStruct.new(
        identifier: identifier,
        input: struct.input,
        about: struct.about,
        domains: struct.domains,
      ).compact
    end

  end
end
