module Divisions
  class Image < ::Divisions::Subdivision
    include PackDefining

    class << self
      def features; [:name, :output_name] ;end
    end

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

    def name; struct.image || derived_features[:name] ;end
    def output_name; struct.output_name || derived_features[:output_name] ;end

    def inflated_struct; inflated.struct ;end

    def default_name; tenant_context_identifier ;end
    def default_output_name; "spaces/#{tenant_context_identifier}:#{default_tag}" ;end
    def default_tag; 'latest' ;end

    def tenant_context_identifier; "#{tenant.identifier}/#{context_identifier.as_path}" ;end

    protected

    def derived_features
      @derived_features ||= {
        name: default_name,
        output_name: default_output_name
      }
    end

  end
end
