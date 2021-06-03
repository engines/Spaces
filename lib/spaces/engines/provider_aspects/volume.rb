require_relative 'aspect'

module ProviderAspects
  class Volume < Aspect

    delegate [:source, :destination] => :division

    def device_stanzas; ;end

    # TERRAFORM SPECIFIC
    def volume_name; "#{blueprint_identifier.hyphenated}-#{source}" ;end
    def pool_name; "#{source}-pool" ;end

  end
end
