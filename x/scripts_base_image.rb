# load the code!
# require './x/universe'

def controllers
  @controllers ||= OpenStruct.new(
    configuration: Spaces::Controllers::RESTController.new(space: :configurations),
    publishing: Publishing::Controllers::Controller.new,
    arenas: Arenas::Controllers::Controller.new,
    packing: Packing::Controllers::Controller.new
  )
end

#set up an arena configuration
params = {
  model: {
    identifier: 'the_arena_config',
    configuration: {
      scheme: 'https',
      address: '192.168.20.220',
      password: 'zinfandel'
    }
  }
}
controllers.configuration.new(**params)

# ------------------------------------------------------------------------------

# import a bootstrappy blueprint
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/docker_arena'})

# ------------------------------------------------------------------------------

# save a basic arena with default associations
controllers.arenas.new(model: {identifier: :base_arena})

# configure the basic arena with the configuration we already set up
controllers.arenas.configure(identifier: :base_arena, configuration_identifier: :the_arena_config)

# ------------------------------------------------------------------------------

# bind a bootstrappy blueprint to the arena
controllers.arenas.bind(identifier: :base_arena, blueprint_identifier: :docker_arena)

# ------------------------------------------------------------------------------

# bind a base blueprint to the arena
controllers.arenas.bind(identifier: :base_arena, blueprint_identifier: :enginesd_debian_base)

# save installations for the bindings
controllers.arenas.install(identifier: :base_arena)

# resolve the arena for the bindings
controllers.arenas.resolve(identifier: :base_arena)

# ------------------------------------------------------------------------------

# save a pack for the base resolution
controllers.packing.new(identifier: 'base_arena::enginesd_debian_base')

# # commit the base pack
# controllers.packing.commit(identifier: 'base_arena::enginesd_debian_base')
