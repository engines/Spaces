# load the code!
# require './x/controllers'

# ------------------------------------------------------------------------------

# import a bootstrappy blueprint
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/debian'}, threaded: false)

# ------------------------------------------------------------------------------

# save a basic arena with default associations
controllers.arenas.create(model: {identifier: :base})

# ------------------------------------------------------------------------------

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :base, image_identifier: :debian)

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})

# define packing providers
controllers.arenas.provide(identifier: :base, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :base, role_identifier: :runtime, provider_identifier: :docker)

# ------------------------------------------------------------------------------

# bind a base blueprint to the arena
controllers.arenas.bind(identifier: :base, blueprint_identifier: :debian)

# stage the arena for the bindings -- should not orchestrate!
controllers.arenas.stage(identifier: :base)

# # build images for the arena
# controllers.arenas.build(identifier: :base, threaded: false)
