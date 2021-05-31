require_relative 'provider_aspect'

module Providers
  class Volume < ProviderAspect

    delegate [:source, :destination] => :division

    def device_stanzas; ;end

    # TERRAFORM SPECIFIC
    def volume_name; "#{blueprint_identifier.hyphenated}-#{source}" ;end
    def pool_name; "#{source}-pool" ;end

  end
end
