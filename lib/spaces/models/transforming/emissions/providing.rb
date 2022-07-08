module Emissions
  module Providing

    def execute(emission, **args)
      interface_for(emission, **args).execute(args[:instruction])
    end

    def interface_for(emission, **args) =
      emission.provider_for(provider_role).interface_for(emission, stream: args[:stream])

  end
end
