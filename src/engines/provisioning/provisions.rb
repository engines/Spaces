module Provisioning
  class Provisions < ::Emissions::Emission

    alias_accessor :resolution, :predecessor

    delegate(
      [:arena, :connect_targets, :stanzas_content] => :resolution
    )

    def connections_provisioned
      connections.map(&:provisioned)
    end

  end
end
