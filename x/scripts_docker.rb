# load the code!
require './x/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# import some blueprints
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/wap'}, threaded: false)
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/phpmyadmin'}, threaded: false)

# ------------------------------------------------------------------------------
# blueprint indices, lists, and gets

controllers.blueprinting.index

controllers.blueprinting.list

controllers.querying.list(method: :binder_identifiers, space: :blueprints)

controllers.blueprinting.show(identifier: :phpmyadmin)
controllers.blueprinting.summarize(identifier: :phpmyadmin)

# ------------------------------------------------------------------------------

# # synchronize a blueprint from a publication
# controllers.blueprinting.synchronize(identifier: :phpmyadmin)
#
# # synchronize a publication from a blueprint
# controllers.publishing.synchronize(identifier: :phpmyadmin)

# ------------------------------------------------------------------------------
# set up an arena topology

# save a basic applications arena
controllers.arenas.create(model: {identifier: :development})
controllers.arenas.state(identifier: :development)

# connect the database arena to the applications arena
controllers.arenas.connect(identifier: :development, other_identifier: :database)

# get a list of binder identifiers that are not yet bound to an arena
controllers.arenas.more_binders(identifier: :development)

# ------------------------------------------------------------------------------

# bind some blueprints to the applications arena
controllers.arenas.bind(identifier: :development, blueprint_identifier: :wap)
controllers.arenas.bind(identifier: :development, blueprint_identifier: :phpmyadmin)
controllers.arenas.state(identifier: :development)

# save installations for the arena
controllers.arenas.install(identifier: :development)
controllers.arenas.state(identifier: :development)

# resolve the arena
controllers.arenas.resolve(identifier: :development)
controllers.arenas.state(identifier: :development)

# # validate a resolution
# Spaces::Commands::Validating.create(identifier: 'development::phpmyadmin', space: :resolutions).run.payload

# save all packs for arena
controllers.arenas.pack(identifier: :development)
controllers.arenas.state(identifier: :development)

# save a pack for a resolution
# controllers.packing.create(identifier: 'development::phpmyadmin')
# controllers.arenas.state(identifier: :development)

# # get the identifiers of packs in an arena
# controllers.querying.list(method: :identifiers, arena_identifier: :development, space: :packs)

# # get the artifact for a pack
# controllers.packing.artifact(identifier: 'development::phpmyadmin')

# provision the arena
controllers.arenas.provision(identifier: :development)

controllers.arenas.state(identifier: :development)

# # build packs for the arena
# controllers.arenas.build(identifier: :development)
#
# # build a pack
# controllers.packing.build(identifier: 'development::phpmyadmin')
#
# # apply provisions for arena
# controllers.arenas.apply(identifier: :development)

# # save provisions for a resolution
# controllers.provisioning.create(identifier: 'development::phpmyadmin')

# capture registry entries for an application
controllers.registry.register(identifier: 'development::phpmyadmin')
