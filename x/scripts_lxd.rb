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

# save a location to an application blueprint
Spaces::Commands::Saving.new(
  model: {repository: 'https://github.com/v2Blueprints/phpmyadmin'},
  space: :locations
).run.payload

# import an application blueprint
Publishing::Commands::Importing.new(identifier: :phpmyadmin, force: true).run.payload

# ------------------------------------------------------------------------------

# save a location to a bootstrappy blueprint
Spaces::Commands::Saving.new(
  model: {repository: 'https://github.com/v2Blueprints/lxd_arena'},
  space: :locations
).run.payload

# import a bootstrappy blueprint
Publishing::Commands::Importing.new(identifier: :lxd_arena, force: true).run.payload

# get a list of all organization blueprint identifiers
Spaces::Commands::Querying.new(method: :organization_identifiers, space: :blueprints).run.payload

# delete an arena
Spaces::Commands::Deleting.new(identifier: :lxd_arena, space: :arenas).run.payload

# save a basic arena with default associations
Arenas::Commands::Saving.new(identifier: :lxd_arena).run.payload

# configure the basic arena with the configuration we already set up
Arenas::Commands::Configuring.new(identifier: :lxd_arena, configuration_identifier: :an_arena_config).run.payload

# get a list of organization blueprint identifiers that are not yet bound to an arena
Arenas::Commands::MoreOrganizations.new(identifier: :lxd_arena).run.payload

# bind an organization blueprint to the arena
Arenas::Commands::Binding.new(identifier: :lxd_arena, blueprint_identifier: :lxd_arena).run.payload

# save installations the arena so far
Arenas::Commands::Installing.new(identifier: :lxd_arena).run.payload

# resolve the arena so far
Arenas::Commands::Resolving.new(identifier: :lxd_arena, force: true).run.payload

# save all packs for an arena
Arenas::Commands::Packing.new(identifier: :lxd_arena).run.payload
# RUN PACKER HERE?

# save provisions for the arena's runtime
Arenas::Commands::RuntimeBooting.new(identifier: :lxd_arena).run.payload
# RUN INIT HERE?

# save provisions for the arena's other providers
Arenas::Commands::Provisioning.new(identifier: :lxd_arena).run.payload
# RUN APPLY HERE FOR INITIAL PROVISIONING? IT MUST HAPPEN BEFORE ...

# save post-initialization provisions for providers
Arenas::Commands::ProviderProvisioning.new(identifier: :lxd_arena).run.payload
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
Arenas::Commands::Binding.new(identifier: :lxd_arena, blueprint_identifier: :phpmyadmin).run.payload

# save installations for the new bindings
Arenas::Commands::Installing.new(identifier: :lxd_arena).run.payload

# resolve the arena including the new bindings
Arenas::Commands::Resolving.new(identifier: :lxd_arena, force: true).run.payload

# get an arena's resolutions
# Arenas::Commands::Resolutions.new(identifier: :lxd_arena).run.payload

# GRAPHING VIA THESE COMMANDS IS DEPRECATED
# # get the blueprint topology for an arena
# Spaces::Commands::Graphing.new(identifier: :lxd_arena, space: :arenas, emission: :blueprint).run.payload

# # get the resolution topology for an arena
# Spaces::Commands::Graphing.new(identifier: :lxd_arena, space: :arenas, emission: :resolution).run.payload

# # validate a resolution
Spaces::Commands::Validating.new(identifier: 'lxd_arena::phpmyadmin', space: :resolutions).run.payload

# # get the status of a resolution
Spaces::Commands::Status.new(identifier: 'lxd_arena::phpmyadmin', space: :resolutions).run.payload

# # get the identifiers of resolutions in an arena
# Spaces::Commands::Querying.new(method: :identifiers, arena_identifier: :lxd_arena, space: :resolutions).run.payload

# save a pack for a resolution
Packing::Commands::Saving.new(identifier: 'lxd_arena::phpmyadmin').run.payload

# # get the identifiers of packs in an arena
# Spaces::Commands::Querying.new(method: :identifiers, arena_identifier: :lxd_arena, space: :packs).run.payload

# # get the artifacts for a pack
Packing::Commands::Artifacts.new(identifier: 'lxd_arena::phpmyadmin').run.payload

# provision the arena for applications
Arenas::Commands::Provisioning.new(identifier: :lxd_arena).run.payload

# # commit a pack
# Packing::Commands::Executing.new(identifier: 'lxd_arena::phpmyadmin', execute: :commit).run.payload
#
# # apply provisions for an arena
# Spaces::Commands::Executing.new(identifier: :lxd_arena, space: :arenas, execute: :apply).run.payload

# # save provisions for a resolution
# Provisioning::Commands::Saving.new(identifier: 'lxd_arena::phpmyadmin').run.payload

# capture registry entries for an application
Registry::Commands::Registering.new(identifier: 'lxd_arena::phpmyadmin').run.payload
