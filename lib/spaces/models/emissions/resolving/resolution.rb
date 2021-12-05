require_relative 'summary'

module Resolving
  class Resolution < ::Settling::Settlement
    include Registering
    include Packing
    include Provisioning
    include ::Resolving::Summary

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:installations, :packs, :provisioning] => :universe,
      [:input, :deployment] =>  :installation
    )

    alias_method :input, :configuration # TODO FIX: probably temporary until installations are declared properly in blueprints

    def installation; @installation ||= installations.by(identifier) ;end

    def complete?
      all_complete?(divisions)
    end

    def image
      images&.first
    end

  end
end
