module Targeting
  module Resolving

    def resolved
      super.tap do |d|
        d.struct.configuration = _resolved(:configuration)
        d.struct.service = _resolved(:service)
      end
    end

    def service_string_array
      _resolved(:service)&.to_string_array
    end

    def _resolved(section)
      if s = send(section)
        resolvable_struct_class.new(s, self).resolved
      end
    end

    def infix_qualifier; target_identifier ;end

  end
end
