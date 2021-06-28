module Providers
  class Docker < ::ProviderAspects::Provider
    module Docker
      class Execution < ::ProviderAspects::Execution

        def packing_artifact
          "CMD #{division.struct[:CMD]}"
        end

      end
    end
  end
end
