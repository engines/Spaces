require_relative 'providing'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Providing

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:arenas, :blueprints] => :universe
    )

    def embedding_keys; @embedding_keys ||= division_keys ;end

    def stanzas_content
      [required_stanza, provider_stanzas].join
    end

    def required_stanza
      %(
        terraform {
          required_providers {
            #{provider_divisions.flatten.map(&:required_stanza).flatten.compact.join}
          }
        }
      )
    end

    def provider_stanzas
      provider_divisions.map(&:arena_stanzas).flatten.compact.join
    end

    def arena; itself ;end

  end
end
