module Provisioning
  class Provisions < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end


    delegate(
      resolutions: :universe,
      [:arena, :images, :volumes, :connect_bindings, :ports] => :resolution
    )

    def predecessor; @predecessor ||= resolutions.by(identifier) ;end

    alias_accessor :resolution, :predecessor

    def keys; composition.keys ;end

    def connections_provisioned
      connections_down.map(&:provisioned)
    end

    def artifacts; stanzas.join("\n") ;end

    def stanzas
      divisions_including_resolution_divisions.map { |d| d.resolution_stanzas_for(self) }.flatten.compact
    end

    def divisions_including_resolution_divisions
      [divisions, resolution.divisions_including_providers].flatten
    end

  end
end
