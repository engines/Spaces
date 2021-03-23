# load the code!
# require './x/universe'

require 'pathname'

$LOAD_PATH.unshift(Pathname.new(__dir__).parent.join('lib').expand_path)

require 'spaces'


universe = Universe.universe

# save a basic arena
arena = Arenas::Arena.new(identifier: 'development')
universe.arenas.save(arena)

# save default associations with arena
arena = universe.arenas.by('development').associated
universe.arenas.save(arena)

# import an arena bootstrap
descriptor = Spaces::Descriptor.new(repository: 'https://github.com/v2Blueprints/arena')
universe.publications.import(descriptor, force: true)

# resolve the bootstrap
arena = universe.arenas.by('development')
bootstrap = universe.blueprints.by(descriptor.identifier)
resolution = bootstrap.with_embeds.resolved_in(arena)
universe.resolutions.save(resolution)

# bootstrap the arena
arena = universe.arenas.by('development')
bootstrapped = arena.bootstrapped_with('arena')
universe.arenas.save(bootstrapped)

# embed blueprints from bootstrap in arena
arena = universe.arenas.by('development')
embedded = arena.with_embeds
universe.arenas.save(embedded)

# save bootstrap packs (only powerdns atm)
resolution = universe.resolutions.by('development/powerdns')
pack = resolution.packed
universe.packs.save(pack)

# save provisions for bootstrap
resolution = universe.resolutions.by('development/arena')
provisions = resolution.provisioned
universe.provisioning.save(provisions)

# import a blueprint
descriptor = Spaces::Descriptor.new(repository: 'https://github.com/v2Blueprints/phpmyadmin')
universe.publications.import(descriptor, force: true)

# resolve a blueprint
blueprint = universe.blueprints.by('phpmyadmin')
arena = universe.arenas.by('development')
resolution = blueprint.with_embeds.resolved_in(arena)
universe.resolutions.save(resolution)

# save a pack for a resolution
resolution = universe.resolutions.by('development/phpmyadmin')
pack = resolution.packed
universe.packs.save(pack)

# save provisions for resolution
resolution = universe.resolutions.by('development/phpmyadmin')
provisions = resolution.provisioned
universe.provisioning.save(provisions)
