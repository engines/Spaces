require_relative 'aspect'

module ProviderAspects
  class Container < Aspect

    delegate [:provisions, :image_name, :commissioning_scripts] => :division
    delegate [:connections_down, :connect_bindings] => :provisions

  end
end
