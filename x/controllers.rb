require './x/universe'

def controllers
  @controllers ||= OpenStruct.new(
    publishing: Publishing::Controllers::Controller.new,
    blueprinting: Blueprinting::Controllers::Controller.new,
    querying: ::Spaces::Controllers::Querying.new,
    arenas: Arenas::Controllers::Controller.new,
    packing: Packing::Controllers::Controller.new,
    provisioning: ::Spaces::Controllers::RESTController.new(space: :provisioning),
    registry: Registry::Controllers::Controller.new
  )
end
