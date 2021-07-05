require_relative 'packing'
require_relative 'provisioning'
require_relative 'status'

module Resolving
  class Resolution < ::Settling::Settlement
    include Packing
    include Provisioning
    include ::Resolving::Status

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:runtime_binding, :packing_binding] => :arena,
      [:installations, :packs, :provisioning] => :universe,
      input: :installation
    )

    def installation; @installation ||= installations.by(identifier) ;end

    def complete?
      all_complete?(divisions)
    end

    def connections_settled
      super { |c| c.resolution_in(arena) }
    end

  end
end
