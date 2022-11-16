module Divisions
  class ManagedPackageList < ::Divisions::Subdivision

    attr_accessor :installer_name
    alias_method :identifier, :installer_name

    def initialize(installer_name:, division:, struct: nil)
      self.installer_name = installer_name
      super(division:, struct: struct || division.struct[identifier])
    end

  end
end
