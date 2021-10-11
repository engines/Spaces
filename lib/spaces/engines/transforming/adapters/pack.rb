require_relative 'emission'

module Adapters
  class Pack < Emission

    alias_method :pack, :emission

  end
end
