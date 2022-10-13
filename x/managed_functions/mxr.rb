# load the code!
# require './x/common/controllers'

# ------------------------------------------------------------------------------

# import mf_infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/managed-functions'}, verbose: true)
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/startup-infrastructure'}, verbose: true)

# ------------------------------------------------------------------------------
# save a providers arena for mf_infrastructure use
controllers.arenas.create(model: {identifier: :mxr})

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :mxr, image_identifier: :base_python)

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform})
controllers.providing.create(model: {identifier: :aws, qualifier: :aws, account_identifier: 910122582945, region: :'ap-southeast-2', zone_identifier: 'ZARIYTT7C12LN'})

# define role providers
controllers.arenas.provide(identifier: :mxr, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :mxr, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws)
controllers.arenas.provide(identifier: :mxr, role_identifier: :runtime, provider_identifier: :docker)

# bind blueprints to the arena
controllers.arenas.bind(identifier: :mxr, blueprint_identifier: 'managed-functions')
controllers.arenas.bind(identifier: :mxr, blueprint_identifier: 'startup-infrastructure')

# ------------------------------------------------------------------------------
# stage some blueprints in the mf_infrastructure arena
controllers.arenas.stage(identifier: :mxr)

# # build images for the arena
# controllers.arenas.build(identifier: :mxr, verbose: true)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :mxr, verbose: true)
