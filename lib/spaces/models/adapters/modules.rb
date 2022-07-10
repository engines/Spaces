module Adapters
  class ModuleList < ::Divisions::ModuleList
  end

  class Modules < Division
    include Keyed
  end
end
