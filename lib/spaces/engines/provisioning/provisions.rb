module Provisioning

  module Artifact #TODO refactor to use same patterns as packing

    def provider_aspect
      @provider_aspect ||= ::Providers::Terraform::Provisions.new(self)
    end

    def artifact
      snippet_map.values.join("\n")
    end

    def snippet_map
      keys.inject({}) do |m, k|
        m.tap { m[k] = snippet_for(k) }
      end.compact
    end

    def snippet_for(key)
      division_map[key]&.provider_division_aspect&.snippets_for(nil)
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

    def snippets
      divisions_including_resolution_divisions.map { |d| d.snippets_for(self) }.flatten.compact
    end

    def divisions_including_resolution_divisions
      [divisions, resolution.divisions_including_providers].flatten
    end

  end
end
