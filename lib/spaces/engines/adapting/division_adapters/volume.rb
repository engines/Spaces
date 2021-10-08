module Adapters
  class Volume < DivisionAdapter

    delegate [:source, :destination] => :division

    def device_snippets; ;end

    # TERRAFORM SPECIFIC
    def volume_name; "#{blueprint_identifier.hyphenated}-#{source}" ;end
    def pool_name; "#{source}-pool" ;end

  end
end
