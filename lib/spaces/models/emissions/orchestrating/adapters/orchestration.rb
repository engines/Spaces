module Adapters
  class Orchestration < ResolvedEmission

    delegate(image: :emission)

    alias_method :orchestration, :emission

    def provider
      provider_for(:orchestration)
    end

    def adapter_name_elements
      [super, qualifier_for(:runtime)].flatten
    end

    def image_identifier
      image&.output_identifier
    end

  end
end
