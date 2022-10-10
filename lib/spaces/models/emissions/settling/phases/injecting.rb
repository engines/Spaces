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

    def injection(binding) = binding.struct.configuration

    def injectable?(binding) = configuration && binding.inject?

    def configuration = binding_target&.struct&.configuration

  end
end
