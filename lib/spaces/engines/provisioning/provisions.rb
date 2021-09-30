module Provisioning

    module Artifact

      def artifact

                pp '.' * 55
                pp klass
                pp identifier
                pp divisions_including_resolution_divisions.map(&:qualifier)                
        stanza_map.values.join("\n")
      end

      def stanza_map
        pp '.' * 11
        pp keys
        keys.inject({}) do |m, k|
          m.tap { m[k] = stanza_for(k) }
        end.compact
      end

      def stanza_for(key)
        division_map[key]&.provider_aspect&.stanzas_for(nil)
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

    # def artifact; stanzas.join("\n") ;end
    #
    def stanzas
      divisions_including_resolution_divisions.map { |d| d.stanzas_for(self) }.flatten.compact
    end

    def divisions_including_resolution_divisions
      [divisions, resolution.divisions_including_providers].flatten
    end

  end
end
