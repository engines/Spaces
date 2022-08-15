module Divisions
  class Resource < ::Divisions::Subdivision

    def identifier = struct.identifier || struct.type

    def resource_identifier =
      [arena.identifier, identifier].join('-').hyphenated

    def configuration = struct.configuration

    #FIX: Resources are masquerading as adapters in artifact stanza processing
    def adapter_keys = []

  end
end
