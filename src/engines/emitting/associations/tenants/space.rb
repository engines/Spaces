module Associations
  class Tenants
    class Space < ::Spaces::Space

      class << self
        def default_model_class
          Tenant
        end
      end

    end
  end
end
