module Divisions
  class Image < ::Divisions::Subdivision

    class << self
      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}::Image")
      end
    end

    delegate(tenant: :emission)

    def identifier; type ;end

    def complete?
      !(type && image).nil?
    end

    def name; struct.name || defaults[:name] ;end
    def output_image; struct.output_image || defaults[:output_image] ;end

    def inflated_struct; inflated.struct ;end

    def post_processor_artifacts; end

    def default_name; tenant_context_identifier ;end
    def default_output_image; "spaces/#{tenant_context_identifier}:#{default_tag}" ;end
    def default_tag; 'latest' ;end

    def tenant_context_identifier; "#{tenant.identifier}/#{context_identifier}" ;end

  end
end
