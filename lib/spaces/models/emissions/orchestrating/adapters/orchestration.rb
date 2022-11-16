module Adapters
  class Orchestration < ResolvedEmission

    delegate(image: :emission)

    alias_method :orchestration, :emission

    def provider = provider_for(:orchestration)

    def adapter_name_elements =
      [super, compute_qualifier, qualifier_for(:runtime)].flatten.compact

  end
end
