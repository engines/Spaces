module Divisions
  class Image < ::Divisions::Binding

    class << self
      def features; super - [:type] + [:output_identifier] ;end
    end

    delegate(tenant: :emission)

    def inflated; self ;end
    def deflated; self ;end

    def base_image_identifier
      targetted_base_identifier || struct.identifier || derived_features[:identifier]
    end

    def targetted_base_identifier
      targetted_base_image&.output_identifier
    end

    def targetted_base_image
      if target_identifier
        blueprint&.images.resolved.first
      end
    end

    def output_identifier; struct.output_identifier || derived_features[:output_identifier] ;end

    def globalized
      super || empty.tap { |m| m.struct = struct.compact }
    end

    def default_identifier; tenant_context_identifier ;end
    def default_output_identifier; "engines_#{tenant_context_identifier}:#{default_tag}" ;end
    def default_tag; 'latest' ;end

    def tenant_context_identifier
       [
         (tenant.identifier unless tenant.identifier == 'engines'),
         context_identifier.underscore
       ].compact.join('_')
     end

    protected

    def derived_features
      @derived_features ||= {
        identifier: default_identifier,
        output_identifier: default_output_identifier
      }
    end

  end
end
