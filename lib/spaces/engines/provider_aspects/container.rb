require_relative 'provider_aspect'

module Providers
  class Container < ProviderAspect

    delegate [:provisions, :image_name, :commissioning_scripts] => :division
    delegate [:connections_down, :connect_bindings] => :provisions

  end
end
