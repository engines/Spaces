require_relative 'status'

module Installing
  class Installation < ::Settling::Settlement
    include Installing::Status

    class << self
      def composition_class; Composition ;end
    end

    delegate(bindings_of_type: :blueprint)

    def connections_settled
      super { |c| c.installation_in(arena) }
    end

  end
end
