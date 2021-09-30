module Providers
  module Packer
    module Lxd
      class Images < ::ProviderAspects::Images

        def packing_stanza; division.to_h ;end

      end
    end
  end
end
