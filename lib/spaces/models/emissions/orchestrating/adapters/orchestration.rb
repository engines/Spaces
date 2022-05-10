module Adapters
  class Orchestration < ResolvedEmission

    delegate(image: :emission)

    alias_method :orchestration, :emission

    def provider
      provider_for(:orchestration)
    end

    def adapter_name_elements
      [super, compute_qualifier_for(:runtime), qualifier_for(:runtime)].flatten.compact
    end

    def image_identifier
      image&.output_identifier
    end

  end
end
