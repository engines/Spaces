require_relative 'emission'

module Adapters
  class Provisions < Emission

    alias_method :provisions, :emission

  end
end
