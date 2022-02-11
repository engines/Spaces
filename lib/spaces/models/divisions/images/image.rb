module Divisions
  class Image < ::Divisions::Binding

    class << self
      def features; super - [:type] + [:output_identifier] ;end
    end

    delegate(
      context_identifier: :division
    )

    def inflated; self ;end
    def deflated; self ;end

    def base_image_identifier
      golden_identifier || struct.identifier || derived_features[:identifier]
    end

    def golden_identifier
      golden_base_image&.struct&.output_identifier
    end

    def golden_base_image
      if potentially_golden?
        blueprint&.images.resolved.first
      end
    end

    def potentially_golden?
      target_identifier
    end

    def output_identifier; struct.output_identifier || derived_features[:output_identifier] ;end

    def globalized
      super || empty.tap { |m| m.struct = struct.compact }
    end

    def default_identifier; context_identifier.underscore ;end
    def default_output_identifier; "#{context_identifier.underscore}:#{default_tag}" ;end
    def default_tag; 'latest' ;end

    protected

    def derived_features
      @derived_features ||= {
        identifier: default_identifier,
        output_identifier: default_output_identifier
      }
    end

  end
end
