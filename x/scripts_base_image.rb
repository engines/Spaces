# load the code!
# require './x/universe'

#set up an arena configuration
params = {
  identifier: 'an_arena_config',
  configuration: {
    scheme: 'https',
    address: '192.168.20.220',
    password: 'zinfandel'
  }
}
Spaces::Commands::Saving.new(identifier: :an_arena_config, model: params, space: :configurations).run.payload

# ------------------------------------------------------------------------------

# save a location to a bootstrappy blueprint
Spaces::Commands::Saving.new(
  model: {repository: 'https://github.com/v2Blueprints/docker_arena'},
  space: :locations
).run.payload

# import a bootstrappy blueprint
Publishing::Commands::Importing.new(identifier: :docker_arena, force: true).run.payload

# ------------------------------------------------------------------------------

# # delete an arena
# Spaces::Commands::Deleting.new(identifier: :base_arena, space: :arenas).run.payload

# save a basic arena with default associations
Arenas::Commands::Saving.new(identifier: :base_arena).run.payload

# configure the basic arena with the configuration we already set up
Arenas::Commands::Configuring.new(identifier: :base_arena, configuration_identifier: :an_arena_config).run.payload

# ------------------------------------------------------------------------------

# bind a bootstrappy blueprint to the arena
Arenas::Commands::Binding.new(identifier: :base_arena, blueprint_identifier: :docker_arena).run.payload

# ------------------------------------------------------------------------------

# bind a base blueprint to the arena
Arenas::Commands::Binding.new(identifier: :base_arena, blueprint_identifier: :enginesd_debian_base).run.payload

# save installations for the bindings
Arenas::Commands::Installing.new(identifier: :base_arena).run.payload

# resolve the arena for the bindings
Arenas::Commands::Resolving.new(identifier: :base_arena).run.payload

# ------------------------------------------------------------------------------

# save a pack for the base resolution
Packing::Commands::Saving.new(identifier: 'base_arena::enginesd_debian_base').run.payload

# # commit the base pack
# Packing::Commands::Executing.new(identifier: 'base_arena::enginesd_debian_base', execute: :commit).run.payload
