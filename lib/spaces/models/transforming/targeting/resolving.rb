module Targeting
  module Resolving

    def service_string_array = _resolved(:service)&.to_string_array

    def _resolved(section)
      if s = send(section)
        resolvable_struct_class.new(s, self).resolved
      end
    end

    def infix_qualifier = target_identifier

  end
end
