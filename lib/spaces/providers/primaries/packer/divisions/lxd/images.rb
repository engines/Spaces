module Providers
  module Packer
    module Lxd
      class Images < ::Adapters::Images

        def packing_snippet; division.to_h ;end

      end
    end
  end
end
