module Artifacts
  module Aws
    module Stanzas
      class Resource < Stanza

        alias_method :stanza, :holder

        relation_accessor :division

        def resource_identifier = [arena.identifier, division.identifier].join('-').hyphenated.abbreviated_to(maximum_identifier_length)

        def resource_type_here =
          resource_type_map[resource_type.to_sym] || resource_type

        def configuration
          @configuration ||= default_configuration.merge(more_configuration).merge(division.configuration)
        end

        def resource_type = division.type

        def initialize(stanza, division)
          super(stanza)
          self.division = division
        end

      end
    end
  end
end
