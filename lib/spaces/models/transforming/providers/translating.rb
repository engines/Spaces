module Providers
  module Translating

    def translator_for(emission)
      translator_class.new(adapter_for(emission))
    end

    def adapter_for(emission)
      adapter_class_for(emission.qualifier).new(self, emission)
    end

    def adapter_class_for(qualifier)
      class_for(:adapters, provider_qualifier, qualifier)
    rescue NameError
      default_adapter_class
    end

    def translator_class; Translator ;end
    def default_adapter_class; ::Adapters::Emission ;end

    def provider_qualifier; name_elements.last ;end

  end
end
