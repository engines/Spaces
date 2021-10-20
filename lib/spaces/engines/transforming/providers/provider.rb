require_relative 'providers'

module Providers
  class Provider < ::Spaces::Model
    include ::Providers::Providers

    attr_accessor :role

    def artifact_for(adapter)
      artifact_class_for(adapter).new(adapter)
    end

    def artifact_class_for(adapter)
      class_for(:artifacts, qualifier, :artifact)
    rescue NameError
      default_artifact_class
    end

    def interface_for(arena_emission, space = nil)
      interface_class.new(adapter_for(arena_emission), space)
    end

    def adapter_for(arena_emission)
      adapter_class_for(arena_emission.qualifier).new(self, arena_emission)
    end

    def interface_class
      class_for(nesting_elements, :interface)
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
