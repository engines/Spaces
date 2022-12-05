# load the code!
# require './src/x/universe'

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
resolution = bootstrap.with_embeds.resolution_in(arena)
universe.resolutions.save(resolution)

# bootstrap the arena
arena = universe.arenas.by('development')
bootstrapped = arena.bootstrapped_with('arena')
universe.arenas.save(bootstrapped)

# embed blueprints from bootstrap in arena
arena = universe.arenas.by('development')
embedded = arena.with_embeds
universe.arenas.save(embedded)

# save orchestration for bootstrap
resolution = universe.resolutions.by('development::arena')
orchestration = resolution.orchestrated
universe.orchestrations.save(orchestration)

# import a blueprint
descriptor = Spaces::Descriptor.new(repository: 'https://github.com/v2Blueprints/phpmyadmin')
universe.publications.import(descriptor, force: true)

# resolve a blueprint
blueprint = universe.blueprints.by('phpmyadmin')
arena = universe.arenas.by('development')
resolution = blueprint.with_embeds.resolution_in(arena)
universe.resolutions.save(resolution)

# save a pack for a resolution
resolution = universe.resolutions.by('development::phpmyadmin')
pack = resolution.packed
universe.packs.save(pack)

# save orchestration for resolution
resolution = universe.resolutions.by('development::phpmyadmin')
orchestration = resolution.orchestrated
universe.orchestrations.save(orchestration)
