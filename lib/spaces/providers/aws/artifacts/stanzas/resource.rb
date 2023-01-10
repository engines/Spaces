module Artifacts
  module Aws
    module Stanzas
      class Resource < Stanza

        alias_method :stanza, :holder

        relation_accessor :division

        def resource_identifier = [arena.identifier, division.identifier].join('-').hyphenated

        def resource_type =
          resource_type_map[division_type.to_sym] || division_type

        def configuration
          @configuration ||= default_configuration.merge(more_configuration).merge(division.configuration)
        end

        def division_type = division.type

        def initialize(stanza, division)
          super(stanza)
          self.division = division
        end

      end
    end
  end
end
