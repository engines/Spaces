module Divisions
  class ServiceTasks < ::Divisions::Division
    include ProviderDependent

    delegate connection_stanza_for: :provider_aspect

    def provider_aspect_name_elements
      ['providers', runtime_identifier, qualifier]
    end

  end
end
