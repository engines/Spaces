module Providers
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class = Provider
    end

    def by(*args) = super.prototype

    def application_qualifiers = default_model_class.application_qualifiers

    def deletion_precondition(identifiable)
      {
        unused_in_arena: !exist_then_by(identifiable)&.used_in_arena?
      }
    end

  end
end
