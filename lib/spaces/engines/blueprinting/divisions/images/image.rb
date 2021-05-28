module Divisions
  class Image < ::Divisions::Subdivision
    include ProviderDependent

    delegate(
      tenant: :emission,
      features: :provider_aspect
    )

    def identifier; type ;end

    def complete?
      !(type && image).nil?
    end

    def inflated; self ;end
    def deflated; self ;end

    def provider_aspect_name_elements
      ['providers', packing_identifier, runtime_identifier, qualifier]
    end

    def name; struct.name || derived_features[:name] ;end
    def output_image; struct.output_image || derived_features[:output_image] ;end

    def inflated_struct; inflated.struct ;end

    def default_name; tenant_context_identifier ;end
    def default_output_image; "spaces/#{tenant_context_identifier}:#{default_tag}" ;end
    def default_tag; 'latest' ;end

    def tenant_context_identifier; "#{tenant.identifier}/#{context_identifier.as_path}" ;end

  end
end
