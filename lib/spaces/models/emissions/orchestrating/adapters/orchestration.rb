module Adapters
  class Orchestration < ResolvedEmission

    delegate(
      [:orchestration_provider, :runtime_qualifier] => :arena,
      image: :emission
    )

    alias_method :provider, :orchestration_provider
    alias_method :orchestration, :emission

    def adapter_name_elements
      [super, runtime_qualifier].flatten
    end

    def image_identifier
      image&.output_identifier
    end

  end
end
