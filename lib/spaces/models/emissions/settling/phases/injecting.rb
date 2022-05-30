module Settling
  module Injecting

    def with_injection
      empty.tap do |m|
        m.struct = struct
        m.binding_target_with_injection!
      end
    end

    def binding_target_with_injection!
      binding_target.struct.configuration =
        configuration.merge(injection) if injectable?
    end

    def injectable?
      injection && configuration
    end

    def injection
      inject_binding&.struct&.configuration
    end

    def inject_binding
      arena.inject_bindings.detect { |b| b.identifier.to_sym == blueprint_identifier.to_sym }
    end

    def configuration
      binding_target&.struct&.configuration
    end

  end
end
