require_relative 'aspect'

module ProviderAspects
  class Packers < Aspect

    delegate packing_artifacts: :division

  end
end
