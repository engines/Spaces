# load the code!
# require './x/universe'

require 'pathname'

$LOAD_PATH.unshift(Pathname.new(__dir__).parent.join('lib').expand_path)

require 'spaces'


universe = Universe.universe

# delete an arena
if universe.arenas.exist?('development')
  arena = universe.arenas.by('development')
  universe.arenas.delete(arena)
end

# save a basic arena
arena = Arenas::Arena.new(identifier: 'development')
universe.arenas.save(arena)

# save default associations with arena
arena = universe.arenas.by('development').associated
universe.arenas.save(arena)

# import an arena bootstrap
descriptor = Spaces::Descriptor.new(repository: 'https://github.com/v2Blueprints/arena')
universe.publications.import(descriptor, force: true)

# bootstrap the arena
arena = universe.arenas.by('development')
bootstrapped = arena.bootstrapped_with('arena')
universe.arenas.save_initial(bootstrapped)
universe.arenas.save(bootstrapped)

# resolve the arena
arena = universe.arenas.by('development')
universe.arenas.save_bootstrap_resolutions_for(arena)

# save bootstrap packs (only powerdns atm)
resolution = universe.resolutions.by('development/powerdns')
pack = resolution.packed
universe.packs.save(pack)

# save provisions for the arena
arena = universe.arenas.by('development')
universe.arenas.save_bootstrap_provisionings_for(arena)

# import a blueprint
descriptor = Spaces::Descriptor.new(repository: 'https://github.com/v2Blueprints/phpmyadmin')
universe.publications.import(descriptor, force: true)

# synchronize a blueprint
universe.blueprints.synchronize_with_publication('phpmyadmin')

# synchronize a publication
universe.publications.synchronize_with_blueprint('phpmyadmin')

# resolve a blueprint
blueprint = universe.blueprints.by('phpmyadmin')
arena = universe.arenas.by('development')
resolution = blueprint.with_embeds.resolved_in(arena)
universe.resolutions.save(resolution)

# get the topology for a resolution
universe.resolutions.graph('development/phpmyadmin').to_json

# save a pack for a resolution
resolution = universe.resolutions.by('development/phpmyadmin')
pack = resolution.packed
universe.packs.save(pack)

# save provisions for resolution
resolution = universe.resolutions.by('development/phpmyadmin')
provisions = resolution.provisioned
universe.provisioning.save(provisions)
