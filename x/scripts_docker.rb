# load the code!
require './x/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# import some blueprints
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/wap'}, threaded: false)
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/phpmyadmin'}, threaded: false)

# ------------------------------------------------------------------------------
# blueprint indices and lists

controllers.blueprinting.index

controllers.blueprinting.list

controllers.querying.list(method: :binder_identifiers, space: :blueprints)

# ------------------------------------------------------------------------------

# blueprint gets
controllers.blueprinting.show(identifier: :phpmyadmin)
controllers.blueprinting.summarize(identifier: :phpmyadmin)

# save a basic arena with default associations
controllers.arenas.create(model: {identifier: :docker_arena})
controllers.arenas.state(identifier: :docker_arena)

# get a list of binder identifiers that are not yet bound to an arena
controllers.arenas.more_binders(identifier: :docker_arena)

# ------------------------------------------------------------------------------

# synchronize a blueprint from a publication
controllers.blueprinting.synchronize(identifier: :phpmyadmin)

# synchronize a publication from a blueprint
controllers.publishing.synchronize(identifier: :phpmyadmin)

# ------------------------------------------------------------------------------

# bind some blueprints to the arena
controllers.arenas.bind(identifier: :docker_arena, blueprint_identifier: :wap)
controllers.arenas.bind(identifier: :docker_arena, blueprint_identifier: :phpmyadmin)
controllers.arenas.state(identifier: :docker_arena)

# save installations for the new bindings
controllers.arenas.install(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)

# resolve the arena including the new bindings
controllers.arenas.resolve(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)

# # validate a resolution
# Spaces::Commands::Validating.create(identifier: 'docker_arena::phpmyadmin', space: :resolutions).run.payload

# save all packs for an arena
controllers.arenas.pack(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)

# save a pack for a resolution
# controllers.packing.create(identifier: 'docker_arena::phpmyadmin')
# controllers.arenas.state(identifier: :docker_arena)

# # get the identifiers of packs in an arena
# controllers.querying.list(method: :identifiers, arena_identifier: :docker_arena, space: :packs)

# # get the artifact for a pack
# controllers.packing.artifact(identifier: 'docker_arena::phpmyadmin')

# provision the arena for applications
controllers.arenas.provision(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)

# # build packs for an arena
# controllers.arenas.build(identifier: :docker_arena)
#
# # build a pack
# controllers.packing.build(identifier: 'docker_arena::phpmyadmin')
#
# # apply provisions for an arena
# controllers.arenas.apply(identifier: :docker_arena)

# # save provisions for a resolution
# controllers.provisioning.create(identifier: 'docker_arena::phpmyadmin')

# capture registry entries for an application
controllers.registry.register(identifier: 'docker_arena::phpmyadmin')
