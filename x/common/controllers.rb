require './x/universe'

def controllers
  @controllers ||= OpenStruct.new(
    universe: Universes::Controllers::Controller.new,
    commands: ::Spaces::Controllers::RESTController.new(space: :commands),
    classifying: ::Spaces::Controllers::RESTController.new(space: :classifiers),
    publishing: Publishing::Controllers::Controller.new,
    blueprinting: Blueprinting::Controllers::Controller.new,
    domains: Domains::Controllers::Controller.new,
    providing: Providing::Controllers::Controller.new,
    arenas: Arenas::Controllers::Controller.new,
    resolving: Resolving::Controllers::Controller.new,
    packing: Packing::Controllers::Controller.new,
    orchestrating: ::Spaces::Controllers::RESTController.new(space: :orchestrations),
    locations: ::Spaces::Controllers::RESTController.new(space: :locations),
    user_keys: Keys::Controllers::Controller.new,
    registry: Registry::Controllers::Controller.new,
    images: Images::Controllers::Controller.new,
    capsules: Capsules::Controllers::Controller.new,
    commissioning: Commissioning::Controllers::Controller.new,
    servicing: Servicing::Controllers::Controller.new,
    streaming: Spaces::Controllers::Streaming.new,
    querying: ::Spaces::Controllers::Querying.new
  )
end
