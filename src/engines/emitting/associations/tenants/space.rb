module Associations
  class Tenants
    class Space < ::Spaces::Space

      def default_model_class
        Tenant
      end

    end
  end
end
