module Providers
  class Docker < ::ProviderAspects::Provider
    module Docker
      class Image < ::ProviderAspects::Image

        delegate image: :division

        def packing_artifact
          "FROM #{image}"
        end

      end
    end
  end
end
