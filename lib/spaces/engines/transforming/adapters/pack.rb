require_relative 'emission'

module Adapters
  class Pack < Emission

    delegate(packing_prerequisite: :arena)

    alias_method :provider, :packing_prerequisite
    alias_method :pack, :emission

  end
end
