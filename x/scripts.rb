# load the code!
# require './x/universe'

require 'pathname'

$LOAD_PATH.unshift(Pathname.new(__dir__).parent.join('lib').expand_path)

require 'spaces'

universe = Universe.universe

# delete an arena
Spaces::Commands::Deleting.new(identifier: 'development', space: :arenas).run.result

# save a basic arena with default associations
Arenas::Commands::Saving.new(identifier: 'development').run.result

# import an arena bootstrap
Publishing::Commands::Importing.new(
  model: {repository: 'https://github.com/v2Blueprints/arena'},
  force: true
).run.result

# bootstrap the arena
Bootstrapping::Commands::Initializing.new(identifier: 'development', blueprint_identifier: 'arena').run.result

# resolve the bootstrap
Bootstrapping::Commands::Resolving.new(identifier: 'development').run.result

# save all packs for an arena
Arenas::Commands::Packing.new(identifier: 'development').run.result

# provision the bootstrap
Arenas::Commands::Provisioning.new(identifier: 'development').run.result

# import a blueprint
Publishing::Commands::Importing.new(
  model: {repository: 'https://github.com/v2Blueprints/phpmyadmin'},
  force: true
).run.result

# synchronize a blueprint
Blueprinting::Commands::Synchronizing.new(identifier: 'phpmyadmin').run.result

# synchronize a publication
Publishing::Commands::Synchronizing.new(identifier: 'phpmyadmin').run.result

# get the topology for a blueprint
Spaces::Commands::Graphing.new(identifier: 'phpmyadmin', space: :blueprints).run.result.to_json

# resolve a blueprint
Blueprinting::Commands::Resolving.new(identifier: 'phpmyadmin', arena_identifier: 'development').run.result

# get the identifiers of all resolutions in an arena
Spaces::Commands::Querying.new(method: 'identifiers', space: :resolutions).run.result

# save a pack for a resolution
Packing::Commands::Saving.new(identifier: 'development::phpmyadmin').run.result

# save provisions for resolution
Provisioning::Commands::Saving.new(identifier: 'development::phpmyadmin').run.result

# save all provisions for an arena
Arenas::Commands::Provisioning.new(identifier: 'development').run.result

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
