module Provisioning
  class Provisions < ::Resolving::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:images, :volumes, :ports, :has?] => :resolution
    )

    def connections_provisioned
      connections_down.map(&:provisioned)
    end

    # def snippets
    #   divisions_including_resolution_divisions.map { |d| d.snippets_for(self) }.flatten.compact
    # end
    #
    # def divisions_including_resolution_divisions
    #   [divisions, resolution.divisions_including_providers].flatten
    # end

  end
end
