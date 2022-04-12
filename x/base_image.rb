# load the code!
# require './x/controllers'

# ------------------------------------------------------------------------------

# import a bootstrappy blueprint
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/debian'}, threaded: false)

# ------------------------------------------------------------------------------

# save a basic arena with default associations
controllers.arenas.create(model: {identifier: :base})

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker_local, qualifier: :docker})

# define packing providers
controllers.arenas.provide(identifier: :base, role_identifier: :packing, provider_identifier: :docker_local)
controllers.arenas.provide(identifier: :base, role_identifier: :runtime, provider_identifier: :docker_local)

# ------------------------------------------------------------------------------

# bind a base blueprint to the arena
controllers.arenas.bind(identifier: :base, blueprint_identifier: :debian)

# resolve the arena for the bindings
controllers.arenas.resolve(identifier: :base)

# ------------------------------------------------------------------------------

# save all packs for an arena
controllers.arenas.pack(identifier: :base)

# # build images for the arena
# controllers.arenas.build(identifier: :base, threaded: false)
