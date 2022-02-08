module Targeting
  module Resolving

    def resolved
      super.tap do |d|
        d.struct.configuration = resolvable_struct_class.new(struct.configuration, self).resolved if struct.configuration
        d.struct.service = resolvable_struct_class.new(struct.service, self).resolved if struct.service
      end
    end

    def infix_qualifier; target_identifier ;end

  end
end
