module Adapters
  module Packer
    module Lxd
      class Images < ::Adapters::Images

        def snippets; division.to_h ;end

      end
    end
  end
end
