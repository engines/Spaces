require_relative 'providers'

module Providers
  class Provider < ::Spaces::Model
    include ::Providers::Providers

    attr_accessor :role

    def interface_for(emission, purpose: nil, space: nil)
      interface_class_for(purpose).new(adapter_for(emission), space)
    end

    def adapter_for(emission)
      adapter_class_for(emission.qualifier).new(self, emission)
    end

    def interface_class_for(purpose = nil)
      class_for(nesting_elements, [purpose, :interface].compact.join('_'))
    end

    def adapter_class_for(qualifier)
      class_for(:adapters, provider_qualifier, qualifier)
    end

    def default_artifact_class; ::Artifacts::Artifact ;end

    def provider_qualifier; name_elements.last ;end

    def initialize(role)
      self.role = role
    end

  end
end
