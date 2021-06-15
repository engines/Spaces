# load the code!
# require './x/universe'

require 'pathname'

$LOAD_PATH.unshift(Pathname.new(__dir__).parent.join('lib').expand_path)

require 'spaces'

universe = Universe.universe

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

# import a bootstrappy blueprint
Publishing::Commands::Importing.new(
  model: {repository: 'https://github.com/v2Blueprints/docker_arena'},
  force: true
).run.payload

# import an application blueprint
Publishing::Commands::Importing.new(
  model: {repository: 'https://github.com/v2Blueprints/phpmyadmin'},
  force: true
).run.payload

# get a list of all organization blueprint identifiers
Spaces::Commands::Querying.new(method: :organization_identifiers, space: :blueprints).run.payload

# delete an arena
Spaces::Commands::Deleting.new(identifier: :docker_arena, space: :arenas).run.payload

# save a basic arena with default associations
Arenas::Commands::Saving.new(identifier: :docker_arena).run.payload

# configure the basic arena with the configuration we already set up
Arenas::Commands::Configuring.new(identifier: :docker_arena, configuration_identifier: :an_arena_config).run.payload

# get a list of organization blueprint identifiers that are not yet bound to an arena
Arenas::Commands::MoreOrganizations.new(identifier: :docker_arena).run.payload

# bind an organization blueprint to the arena
Arenas::Commands::Binding.new(identifier: :docker_arena, blueprint_identifier: :docker_arena).run.payload

# save installations the arena so far
Arenas::Commands::Installing.new(identifier: :docker_arena).run.payload

# resolve the arena so far
Arenas::Commands::Resolving.new(identifier: :docker_arena).run.payload

# save all packs for an arena
Arenas::Commands::Packing.new(identifier: :docker_arena).run.payload
# RUN PACKER HERE?

# save provisions for the arena's runtime
Arenas::Commands::RuntimeBooting.new(identifier: :docker_arena).run.payload
# RUN INIT HERE?

# save provisions for the arena's other providers
Arenas::Commands::Provisioning.new(identifier: :docker_arena).run.payload
# RUN APPLY HERE FOR INITIAL PROVISIONING? IT MUST HAPPEN BEFORE ...

# save post-initialization provisions for providers
Arenas::Commands::ProviderProvisioning.new(identifier: :docker_arena).run.payload
# RUN APPLY HERE FOR INITIAL PROVISIONING?

#
# THE ARENA SHOULD BE BOOSTRAPPED BY THIS POINT
#

# # export a blueprint
# Publishing::Commands::Exporting.new(identifier: :phpmyadmin, message: nil).run.payload

# # get the status of a publication
# Spaces::Commands::Status.new(identifier: :phpmyadmin, space: :publications).run.payload

# synchronize a blueprint
Blueprinting::Commands::Synchronizing.new(identifier: :phpmyadmin).run.payload

# synchronize a publication
Publishing::Commands::Synchronizing.new(identifier: :phpmyadmin).run.payload

# bind another blueprint to the arena
Arenas::Commands::Binding.new(identifier: :docker_arena, blueprint_identifier: :phpmyadmin).run.payload

# save installations for the new bindings
Arenas::Commands::Installing.new(identifier: :docker_arena).run.payload

# resolve the arena again for the new bindings
Arenas::Commands::Resolving.new(identifier: :docker_arena).run.payload
# PROBABLY SHOULD BE REFINED TO RESOLVE ONLY NEW BLUEPRINTS SINCE LAST RESOLVING
# EXPLICT FRESH RESOLUTION SHOULD PROBABLY BE DONE MANUALLY
# THE PROBLEM IS: fresh passwords get regenerated ... there's probably other side effects as well

# get an arena's resolutions
Arenas::Commands::Resolutions.new(identifier: :docker_arena).run.payload

# GRAPHING VIA THESE COMMANDS IS DEPRECATED
# # get the blueprint topology for an arena
# Spaces::Commands::Graphing.new(identifier: :docker_arena, space: :arenas, emission: :blueprint).run.payload

# # get the resolution topology for an arena
# Spaces::Commands::Graphing.new(identifier: :docker_arena, space: :arenas, emission: :resolution).run.payload

# # validate a resolution
# Spaces::Commands::Validating.new(identifier: 'docker_arena::phpmyadmin', space: :resolutions).run.payload

# # get the status of a resolution
# Spaces::Commands::Status.new(identifier: 'docker_arena::phpmyadmin', space: :resolutions).run.payload

# # get the identifiers of resolutions in an arena
# Spaces::Commands::Querying.new(method: :identifiers, arena_identifier: :docker_arena, space: :resolutions).run.payload

# save a pack for a resolution
Packing::Commands::Saving.new(identifier: 'docker_arena::phpmyadmin').run.payload

# # get the identifiers of packs in an arena
# Spaces::Commands::Querying.new(method: :identifiers, arena_identifier: :docker_arena, space: :packs).run.payload

# # get the artifacts for a pack
# Packing::Commands::Artifacts.new(identifier: 'docker_arena::phpmyadmin').run.payload

# provision the arena for applications
Arenas::Commands::Provisioning.new(identifier: :docker_arena).run.payload

# # commit a pack
# Packing::Commands::Executing.new(identifier: 'docker_arena::phpmyadmin', execute: :commit).run.payload
#
# # apply provisions for an arena
# Spaces::Commands::Executing.new(identifier: :docker_arena, space: :arenas, execute: :apply).run.payload

# # save provisions for a resolution
# Provisioning::Commands::Saving.new(identifier: 'docker_arena::phpmyadmin').run.payload
