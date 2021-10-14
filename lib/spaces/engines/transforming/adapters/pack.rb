require_relative 'emission'

module Adapters
  class Pack < Emission

    delegate(packing_provider: :arena)

    alias_method :provider, :packing_provider
    alias_method :pack, :emission

  end
end
