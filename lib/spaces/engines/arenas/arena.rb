require_relative 'boostrapping'
require_relative 'providing'
require_relative 'resolving'
require_relative 'provisioning'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Bootstrapping
    include ::Arenas::Providing
    include ::Arenas::Resolving
    include ::Arenas::Provisioning

    class << self
      def composition_class; Composition ;end
    end

    delegate([:arenas, :blueprints] => :universe)

    def runtime_binding
      @runtime_binding ||= turtle_targets.detect(&:runtime_binding?)
    end

    def artifact
      [required_stanza, arena_stanzas].join
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

    def arena_stanzas
      provider_divisions.map(&:arena_stanzas).flatten.compact.join
    end

    def arena; itself ;end

  end
end
