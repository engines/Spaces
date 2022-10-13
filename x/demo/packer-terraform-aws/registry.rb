# ------------------------------------------------------------------------------

# import blueprint to store a base image
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/container-registry'}, verbose: true).to_json

# ------------------------------------------------------------------------------

# save a basic arena with default associations
controllers.arenas.create(model: {identifier: :registry}).to_json

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker}).to_json
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform}).to_json
controllers.providing.create(model: {identifier: :aws, qualifier: :aws, account_identifier: 910122582945, region: :'ap-southeast-2', zone_identifier: 'ZARIYTT7C12LN'}).to_json

# define role providers
controllers.arenas.provide(identifier: :registry, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws).to_json
controllers.arenas.provide(identifier: :registry, role_identifier: :runtime, provider_identifier: :docker).to_json

# ------------------------------------------------------------------------------

# bind blueprints to the arena
controllers.arenas.bind(identifier: :registry, blueprint_identifier: :'container-registry').to_json

# stage the arena for the bindings
controllers.arenas.stage(identifier: :registry).to_json

# build images for the arena
controllers.arenas.build(identifier: :registry, verbose: true).to_json

# bring up containers for arena
controllers.arenas.plan(identifier: :registry, verbose: true).to_json
