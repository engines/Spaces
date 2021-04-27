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

# import an arena bootstrap
Publishing::Commands::Importing.new(
  model: {repository: 'https://github.com/v2Blueprints/arena'},
  force: true
).run.payload

# bootstrap the arena
Bootstrapping::Commands::Initializing.new(identifier: :development, blueprint_identifier: 'arena').run.payload

# resolve the bootstrap
Bootstrapping::Commands::Resolving.new(identifier: :development).run.payload

# save all packs for an arena
Arenas::Commands::Packing.new(identifier: :development).run.payload

# provision the bootstrap
Arenas::Commands::Provisioning.new(identifier: :development).run.payload

# import a blueprint
Publishing::Commands::Importing.new(
  model: {repository: 'https://github.com/v2Blueprints/phpmyadmin'},
  force: true
).run.payload

# get the status of a publication
Spaces::Commands::Status.new(identifier: :phpmyadmin, space: :publications).run.payload

# synchronize a blueprint
Blueprinting::Commands::Synchronizing.new(identifier: :phpmyadmin).run.payload

# synchronize a publication
Publishing::Commands::Synchronizing.new(identifier: :phpmyadmin).run.payload

# get the topology for a blueprint
Spaces::Commands::Graphing.new(identifier: :phpmyadmin, space: :blueprints).run.payload

# resolve a blueprint
Blueprinting::Commands::Resolving.new(identifier: :phpmyadmin, arena_identifier: :development).run.payload

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

# save provisions for resolution
Provisioning::Commands::Saving.new(identifier: 'development::phpmyadmin').run.payload

# save all provisions for an arena
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
