module Targeting
  module Resolving

    def resolved
      super.tap do |d|
        d.struct.configuration = resolvable_struct_class.new(configuration, self).resolved if configuration
        d.struct.service = resolvable_struct_class.new(service, self).resolved if service
      end
    end

    def infix_qualifier; target_identifier ;end

  end
end
