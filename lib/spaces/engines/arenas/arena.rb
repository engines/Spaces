require_relative 'binding'
require_relative 'providing'
require_relative 'resolving'
require_relative 'packing'
require_relative 'provisioning'

module Arenas
  class Arena < ::Emissions::Emission
    include ::Arenas::Binding
    include ::Arenas::Providing
    include ::Arenas::Resolving
    include ::Arenas::Packing
    include ::Arenas::Provisioning

    class << self
      def composition_class; Composition ;end
    end

    delegate([:arenas, :blueprints] => :universe)

    def runtime_binding
      @runtime_binding ||= deep_bindings.detect(&:runtime_binding?)
    end

    def initial_artifacts
      %(
        terraform {
          required_providers {
            #{providers.flatten.map(&:required_stanza).flatten.compact.join}
          }
        }
      )
    end

    def runtime_artifacts
      runtime_provider.provider_stanzas
    end

    def arena; itself ;end

    def method_missing(m, *args, &block)
      provider_map["#{m}"] || super
    end

    def respond_to_missing?(m, *)
      provider_map.keys.include?("#{m}") || super
    end

  end
end
