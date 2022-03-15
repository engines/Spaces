require './x/universe'

def controllers
  @controllers ||= OpenStruct.new(
    universe: Universes::Controllers::Controller.new,
    publishing: Publishing::Controllers::Controller.new,
    blueprinting: Blueprinting::Controllers::Controller.new,
    querying: ::Spaces::Controllers::Querying.new,
    arenas: Arenas::Controllers::Controller.new,
    resolving: Resolving::Controllers::Controller.new,
    packing: Packing::Controllers::Controller.new,
    provisioning: ::Spaces::Controllers::RESTController.new(space: :provisioning),
    locations: ::Spaces::Controllers::RESTController.new(space: :locations),
    user_keys: Keys::Controllers::Controller.new,
    registry: Registry::Controllers::Controller.new,
    commissioning: Commissioning::Controllers::Controller.new,
    servicing: Servicing::Controllers::Controller.new,
    streaming: Spaces::Controllers::Streaming.new,
    domains: Domains::Controllers::Controller.new
  )
end
