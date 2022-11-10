module Adapters
    class BundledPackages < Divisible

    def subadapter_for(subdivision) =
      subadapter_class.dynamic_type(subdivision)

  end
end
