module Settling
  module Injecting

    def with_injection(binding)
      empty.tap do |m|
        m.struct = struct
        m.maybe_inject_with!(binding)
      end
    end

    def maybe_inject_with!(binding)
      binding_target.struct.configuration =
        configuration.merge(injection(binding)) if injectable?(binding)
    end

    def injection(binding)
      binding.struct.configuration
    end

    def injectable?(binding)
      configuration && binding.inject?
    end

    def configuration
      binding_target&.struct&.configuration
    end

  end
end
