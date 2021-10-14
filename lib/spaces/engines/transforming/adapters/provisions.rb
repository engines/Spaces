require_relative 'emission'

module Adapters
  class Provisions < Emission

    delegate([:provisions_provider, :runtime_qualifier] => :arena)

    alias_method :provider, :provisions_provider
    alias_method :provisions, :emission

    def adapter_name_elements
      [super, runtime_qualifier].flatten
    end

  end
end
