module Adapters
  class ManagedPackageList < ::Divisions::ManagedPackageList
  end

  class ManagedPackages < Division
    include Keyed
  end
end
