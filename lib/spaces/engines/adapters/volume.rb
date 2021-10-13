module Adapters
  class Volume < Adapter

    delegate [:source, :destination] => :division

    # TODO: TERRAFORM SPECIFIC!
    def volume_name; "#{blueprint_identifier.hyphenated}-#{source}" ;end
    def pool_name; "#{source}-pool" ;end

  end
end
