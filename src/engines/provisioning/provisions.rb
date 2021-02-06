module Provisioning
  class Provisions < ::Emissions::Emission

    alias_accessor :resolution, :predecessor

    delegate(
      [:arena, :connect_targets, :stanzas_content] => :resolution
    )

    def connections
      connect_targets.map{ |t| t.resolution_in(arena) }
    end

    def connections_provisioned
      connections.map(&:provisioned)
    end

  end
end
