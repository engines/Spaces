require_relative 'boostrapping'
require_relative 'providing'
require_relative 'bootstrap_resolving'
require_relative 'packing'
require_relative 'provisioning'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Bootstrapping
    include ::Arenas::Providing
    include ::Arenas::BootstrapResolving
    include ::Arenas::Packing
    include ::Arenas::Provisioning

    class << self
      def composition_class; Composition ;end
    end

    delegate([:arenas, :blueprints] => :universe)

    def resolutions
      identifiers.map { |i| universe.resolutions.by(i) }
    end

    def identifiers
      universe.resolutions.identifiers(arena_identifier: identifier)
    end

    def runtime_binding
      @runtime_binding ||= deep_bindings.detect(&:runtime_binding?)
    end

    def artifact; arena_stanzas ;end
    def initial_artifact; required_stanza ;end

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
