module Providers
  module Adapting

    def adapting_interface_for(emission, purpose: nil, space: nil)
      adapting_interface_class_for(purpose).new(adapter_for(emission), space)
    end

    def adapter_for(emission)
      adapter_class_for(emission.qualifier).new(self, emission)
    end

    def adapting_interface_class_for(purpose = nil)
      class_for(nesting_elements, [purpose, :interface].compact.join('_'))
    end

    def adapter_class_for(qualifier)
      class_for(:adapters, provider_qualifier, qualifier)
    rescue NameError
      default_adapter_class
    end

    def default_adapter_class; ::Adapters::Emission ;end
    def default_artifact_class; ::Artifacts::Artifact ;end

    def provider_qualifier; name_elements.last ;end

  end
end
