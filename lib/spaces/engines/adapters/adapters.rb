module Adapters

  class Configuration < Adapter ;end
  class Default < Adapter ;end
  class Images < Divisible ;end
  class Image < Adapter ;end
  ModuleList = ::Divisions::ModuleList
  class Modules < Keyed ;end
  class OtherPackages < Divisible ;end
  class OtherPackage < Adapter ;end
  class Permission < Adapter ;end
  class Permissions < Divisible ;end
  class Ports < Divisible ;end
  class Port < Adapter ;end
  class SystemPackages < Keyed ;end
  class Volumes < Divisible ;end
  class Volume < Adapter ;end

end
