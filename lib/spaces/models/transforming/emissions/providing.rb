module Emissions
  module Providing

    def execute(instruction, emission)
      interface_for(emission).execute(instruction)
    end

    def interface_for(emission)
      emission.provider_for(provider_role).interface_for(emission)
    end

  end
end
