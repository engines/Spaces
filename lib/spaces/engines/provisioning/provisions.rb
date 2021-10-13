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

  end
end
