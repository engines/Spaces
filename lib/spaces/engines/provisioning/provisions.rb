module Provisioning

  module Artifact

    def provider_aspect
      @provider_aspect ||= ::Providers::Terraform::Provisions.new(self)
    end

    def artifact
      stanza_map.values.join("\n")
    end

    def stanza_map
      keys.inject({}) do |m, k|
        m.tap { m[k] = stanza_for(k) }
      end.compact
    end

    def stanza_for(key)
      division_map[key]&.provider_division_aspect&.stanzas_for(nil)
    end
  end

  class Provisions < ::Resolving::Emission
    include Artifact

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:images, :volumes, :ports, :has?] => :resolution
    )

    def connections_provisioned
      connections_down.map(&:provisioned)
    end

    def stanzas
      divisions_including_resolution_divisions.map { |d| d.stanzas_for(self) }.flatten.compact
    end

    def divisions_including_resolution_divisions
      [divisions, resolution.divisions_including_providers].flatten
    end

  end
end
