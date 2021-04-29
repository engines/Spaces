# load the code!
# require './x/universe'

require 'pathname'

$LOAD_PATH.unshift(Pathname.new(__dir__).parent.join('lib').expand_path)

require 'spaces'

universe = Universe.universe

# delete an arena
Spaces::Commands::Deleting.new(identifier: :development, space: :arenas).run.payload

# save a basic arena with default associations
Arenas::Commands::Saving.new(identifier: :development).run.payload

# import a bootstrappy blueprint
Publishing::Commands::Importing.new(
  model: {repository: 'https://github.com/v2Blueprints/arena'},
  force: true
).run.payload

# bind the blueprint to the arena
Arenas::Commands::Binding.new(identifier: :development, blueprint_identifier: :arena).run.payload

# resolve the arena so far
Arenas::Commands::Resolving.new(identifier: :development).run.payload

# save all packs for an arena
Arenas::Commands::Packing.new(identifier: :development).run.payload

# provision the arena
Arenas::Commands::Provisioning.new(identifier: :development).run.payload

# import an application blueprint
Publishing::Commands::Importing.new(
  model: {repository: 'https://github.com/v2Blueprints/phpmyadmin'},
  force: true
).run.payload

# export a blueprint
Publishing::Commands::Exporting.new(identifier: :phpmyadmin, message: nil).run.payload

# get the status of a publication
Spaces::Commands::Status.new(identifier: :phpmyadmin, space: :publications).run.payload

# synchronize a blueprint
Blueprinting::Commands::Synchronizing.new(identifier: :phpmyadmin).run.payload

# synchronize a publication
Publishing::Commands::Synchronizing.new(identifier: :phpmyadmin).run.payload

# bind another blueprint to the arena
Arenas::Commands::Binding.new(identifier: :development, blueprint_identifier: :phpmyadmin).run.payload

# resolve the arena again for the new bindings
Arenas::Commands::Resolving.new(identifier: :development).run.payload

# get the blueprint topology for an arena
Spaces::Commands::Graphing.new(identifier: :development, space: :arenas, emission: :blueprint).run.payload

# get the resolution topology for an arena
Spaces::Commands::Graphing.new(identifier: :development, space: :arenas, emission: :resolution).run.payload

# validate a resolution
Spaces::Commands::Validating.new(identifier: 'development::phpmyadmin', space: :resolutions).run.payload

# get the status of a resolution
Spaces::Commands::Status.new(identifier: 'development::phpmyadmin', space: :resolutions).run.payload

# get the identifiers of resolutions in an arena
Spaces::Commands::Querying.new(method: :identifiers, arena_identifier: :development, space: :resolutions).run.payload

# save a pack for a resolution
Packing::Commands::Saving.new(identifier: 'development::phpmyadmin').run.payload

# get the identifiers of packs in an arena
Spaces::Commands::Querying.new(method: :identifiers, arena_identifier: :development, space: :packs).run.payload

# get the artifacts for a pack
Packing::Commands::Artifacts.new(identifier: 'development::phpmyadmin').run.payload

# # save provisions for resolution
# Provisioning::Commands::Saving.new(identifier: 'development::phpmyadmin').run.payload

# provision the arena again
Arenas::Commands::Provisioning.new(identifier: :development).run.payload

# params = {
#   identifier: 'lxd',
#   model: {
#     :identifier=>"lxd",
#     :about=>{:title=>"lxd", :explanation=>"New LXD Configuration <--------------"},
#     :provider=>{:type=>"lxd"},
#     :configuration=>{:version=>"1.5.0", :source=>"terraform-lxd/lxd",
#     :generate_client_certificates=>true,
#     :accept_remote_certificate=>true,
#     :password=>"^^random(16)^^"}
#   }
# }
# s = Spaces::Commands::Saving.new(identifier: 'lxd', model: params, space: :blueprints)
