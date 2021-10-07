require_relative 'emission_adapter'

module Providers
  class PackAdapter < EmissionAdapter

    alias_method :pack, :emission

  end
end
