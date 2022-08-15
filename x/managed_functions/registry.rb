# load the code!
# require './x/common/controllers'

# ------------------------------------------------------------------------------

# import blueprint to store a base image
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/container-registry'}, verbose: true)

# ------------------------------------------------------------------------------

# save a basic arena with default associations
controllers.arenas.create(model: {identifier: :registry})

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform})
controllers.providing.create(model: {identifier: :aws, qualifier: :aws, region: :'ap-southeast-2'})

# define role providers
controllers.arenas.provide(identifier: :registry, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws)
controllers.arenas.provide(identifier: :registry, role_identifier: :runtime, provider_identifier: :docker)

# ------------------------------------------------------------------------------

# bind blueprints to the arena
controllers.arenas.bind(identifier: :registry, blueprint_identifier: :'container-registry')

# stage the arena for the bindings
controllers.arenas.stage(identifier: :registry)
