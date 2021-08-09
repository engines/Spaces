require_relative 'summary'

module Installing
  class Installation < ::Settling::Settlement
    include Installing::Summary

    class << self
      def composition_class; Composition ;end
    end

    delegate(bindings_of_type: :blueprint)

    def connections_settled
      super { |c| c.installation_in(arena) }
    end

  end
end
