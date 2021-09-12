# load the code!
# require './x/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# import a bootstrappy blueprint
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/docker_arena'})

# ------------------------------------------------------------------------------

# import an application blueprint
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/phpmyadmin'})

# ------------------------------------------------------------------------------
# blueprint indices and lists

controllers.blueprinting.index

controllers.blueprinting.list

controllers.querying.list(method: :binder_identifiers, space: :blueprints)

# ------------------------------------------------------------------------------

# blueprint gets
controllers.blueprinting.show(identifier: :phpmyadmin)
controllers.blueprinting.summary(identifier: :phpmyadmin)

# save a basic arena with default associations
controllers.arenas.create(model: {identifier: :docker_arena})
controllers.arenas.state(identifier: :docker_arena)

# get a list of binder identifiers that are not yet bound to an arena
controllers.arenas.more_binders(identifier: :docker_arena)

# ------------------------------------------------------------------------------

# bind a bootstrappy blueprint to the arena
controllers.arenas.bind(identifier: :docker_arena, blueprint_identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)

# ------------------------------------------------------------------------------

# save installations for the arena so far
controllers.arenas.install(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)

# resolve the arena so far
controllers.arenas.resolve(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)

# ------------------------------------------------------------------------------

# save all packs for an arena
controllers.arenas.pack(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)
# RUN PACKER HERE?

# save provisions for the arena's runtime
controllers.arenas.runtime(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)
# RUN INIT HERE?

# save provisions for the arena's other providers
controllers.arenas.provision(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)
# RUN APPLY HERE FOR INITIAL PROVISIONING? IT MUST HAPPEN BEFORE ...

# save post-initialization provisions for providers
controllers.arenas.provision_providers(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)
# RUN APPLY HERE FOR INITIAL PROVISIONING?

#
# THE ARENA SHOULD BE BOOSTRAPPED BY THIS POINT
#

# ------------------------------------------------------------------------------

# synchronize a blueprint to a publication
controllers.blueprinting.synchronize(identifier: :phpmyadmin)

# synchronize a publication to a blueprint
controllers.publishing.synchronize(identifier: :phpmyadmin)

# ------------------------------------------------------------------------------

# bind another blueprint to the arena
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

# save a pack for a resolution
controllers.packing.create(identifier: 'docker_arena::phpmyadmin')
controllers.arenas.state(identifier: :docker_arena)

# # get the identifiers of packs in an arena
# controllers.querying.list((method: :identifiers, arena_identifier: :docker_arena, space: :packs)

# # get the artifacts for a pack
# controllers.packing.artifacts(identifier: 'docker_arena::phpmyadmin')

# provision the arena for applications
controllers.arenas.provision(identifier: :docker_arena)
controllers.arenas.state(identifier: :docker_arena)

# # commit a pack
# controllers.packing.commit(identifier: 'docker_arena::phpmyadmin')
#
# # apply provisions for an arena
# controllers.arenas.apply(identifier: :docker_arena)

# # save provisions for a resolution
# controllers.provisioning.create(identifier: 'docker_arena::phpmyadmin')

# capture registry entries for an application
controllers.registry.register(identifier: 'docker_arena::phpmyadmin')
