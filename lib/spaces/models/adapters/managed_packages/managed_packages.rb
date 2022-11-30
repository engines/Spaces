module Adapters
  class ManagedPackages < Divisible

    class << self
      def subadapter_class = ManagedPackageList
    end

    delegate(subadapter_class: :klass)

  end
end
