# load the code!
# require './x/common/controllers'

# ------------------------------------------------------------------------------

# import mf_infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/managed-functions'}, verbose: true)
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/startup-infrastructure'}, verbose: true)

# ------------------------------------------------------------------------------
# save a providers arena for mf_infrastructure use
controllers.arenas.create(model: {identifier: :applications})

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :applications, image_identifier: :'python:3.8-slim-buster')
# controllers.arenas.build_from(identifier: :applications, image_identifier: :base_python)

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform})
controllers.providing.create(model: {identifier: :'ap-southeast-2', qualifier: :aws, account_identifier: 910122582945, region: :'ap-southeast-2', zone_identifier: 'ZARIYTT7C12LN'})
controllers.providing.create(model: {identifier: :'us-east-1', qualifier: :aws, account_identifier: 910122582945, region: :'us-east-1', zone_identifier: 'ZARIYTT7C12LN'})

# define role providers
controllers.arenas.provide(identifier: :applications, role_identifier: :packing, provider_identifier: :docker, compute_identifier: :'us-east-1')
controllers.arenas.provide(identifier: :applications, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :'ap-southeast-2')
controllers.arenas.provide(identifier: :applications, role_identifier: :runtime, provider_identifier: :docker)

# bind blueprints to the arena
controllers.arenas.bind(identifier: :applications, blueprint_identifier: 'managed-functions')
controllers.arenas.bind(identifier: :applications, blueprint_identifier: 'startup-infrastructure')

# ------------------------------------------------------------------------------
# stage some blueprints in the mf_infrastructure arena
controllers.arenas.stage(identifier: :applications)

# # build images for the arena
# controllers.arenas.build(identifier: :applications, verbose: true)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :applications, verbose: true)
