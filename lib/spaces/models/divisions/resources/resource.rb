module Divisions
  class Resource < ::Divisions::Subdivision

    def identifier = struct.identifier || struct.type

    def type_identifier =
      [struct.type, identifier].join('_')

    def resource_identifier =
      [arena.identifier, identifier].join('-').hyphenated

    def configuration = struct.configuration

  end
end
