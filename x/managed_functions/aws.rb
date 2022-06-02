# load the code!
# require './x/controllers'

# ------------------------------------------------------------------------------

# import mf_infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/managed-functions'}, threaded: false)
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/startup-infrastructure'}, threaded: false)

# ------------------------------------------------------------------------------
# save a providers arena for mf_infrastructure use
controllers.arenas.create(model: {identifier: :managed_functions})

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :managed_functions, image_identifier: :base_python)

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform})
controllers.providing.create(model: {identifier: :aws, qualifier: :aws})

# define role providers
controllers.arenas.provide(identifier: :managed_functions, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :managed_functions, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws)
controllers.arenas.provide(identifier: :managed_functions, role_identifier: :runtime, provider_identifier: :docker)

# bind blueprints to the arena
controllers.arenas.bind(identifier: :managed_functions, blueprint_identifier: 'managed-functions')
controllers.arenas.bind(identifier: :managed_functions, blueprint_identifier: 'startup-infrastructure')

# ------------------------------------------------------------------------------
# stage some blueprints in the mf_infrastructure arena
controllers.arenas.stage(identifier: :managed_functions)

# # build images for the arena
# controllers.arenas.build(identifier: :managed_functions, threaded: false)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :managed_functions, threaded: false)
