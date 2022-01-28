require_relative 'summary'

module Resolving
  class Resolution < ::Settling::Settlement
    include Registering
    include Packing
    include Provisioning
    include Commissioning
    include Consuming
    include Servicing
    include ::Resolving::Summary

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:installations, :packs, :provisioning, :registry] => :universe,
      [:input, :deployment] => :installation
    )

    def installation; @installation ||= installations.by(identifier) ;end

    def configuration
      super.class.new(emission: self, struct: super.struct.merge(input.struct))
    end

    def complete?
      all_complete?(divisions)
    end

    def image
      images&.first
    end

    def direct_connections
      connect_bindings.map(&:resolution).compact
    end

  end
end
