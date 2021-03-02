# load the code!
# require './src/x/universe'

# save a basic arena
arena = Arenas::Arena.new(identifier: 'development')
universe.arenas.save(arena)

# save default associations with arena
arena = universe.arenas.by('development').associated
universe.arenas.save(arena)

# import an arena bootstrap
descriptor = Spaces::Descriptor.new(repository: 'https://github.com/MarkRatjens/arena')
universe.publications.import(descriptor, force: true)

# resolve the bootstrap
arena = universe.arenas.by('development')
bootstrap = universe.blueprints.by(descriptor.identifier)
resolution = bootstrap.with_embeds.resolved_in(arena)
universe.resolutions.save(resolution)

# bootstrap the arena
arena = universe.arenas.by('development')
boostrapped = arena.bootstrapped_with('arena')
universe.arenas.save(boostrapped)

# embed blueprints from bootstrap in arena
arena = universe.arenas.by('development')
embedded = arena.with_embeds
universe.arenas.save(embedded)

# import a blueprint
descriptor = Spaces::Descriptor.new(repository: 'https://github.com/v2Blueprints/mariadb')
universe.publications.import(descriptor, force: true)

# resolve a blueprint
blueprint = universe.blueprints.by('mariadb')
arena = universe.arenas.by('development')
resolution = blueprint.with_embeds.resolved_in(arena)
universe.resolutions.save(resolution)

# save a pack for a resolution
resolution = universe.resolutions.by('development/mariadb')
pack = resolution.packed
universe.packs.save(pack)

# commit a pack
pack = universe.packs.by('development/mariadb')
universe.packs.commit(pack)

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

# commit a pack
pack = universe.packs.by('development/phpmyadmin')
universe.packs.commit(pack)

# save provisions for resolution
resolution = universe.resolutions.by('development/phpmyadmin')
provisions = resolution.provisioned
universe.provisioning.save(provisions)

# apply arena provisions
arena = universe.arenas.by('development')
universe.arenas.apply(arena)
