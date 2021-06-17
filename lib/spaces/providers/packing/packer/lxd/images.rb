module Providers
  class Packer < ::ProviderAspects::Provider
    module Lxd
      class Images < ::ProviderAspects::Images

        def packing_artifact; division.to_h ;end

      end
    end
  end
end
