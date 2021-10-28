module Adapters
  class Provisions < ResolvedEmission

    delegate(
      [:provisioning_provider, :runtime_qualifier] => :arena,
      image: :emission
    )

    alias_method :provider, :provisioning_provider
    alias_method :provisions, :emission

    def adapter_name_elements
      [super, runtime_qualifier].flatten
    end

    def image_name
      image&.output_name
    end

  end
end
