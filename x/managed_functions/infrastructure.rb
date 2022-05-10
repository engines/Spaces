# load the code!
# require './x/controllers'

# ------------------------------------------------------------------------------

# import mf_infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/aws-example-1'}, threaded: false)

# ------------------------------------------------------------------------------
# save a providers arena for mf_infrastructure use
controllers.arenas.create(model: {identifier: :mf_infrastructure})

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :mf_infrastructure, image_identifier: :base_debian)

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform})
controllers.providing.create(model: {identifier: :aws, qualifier: :aws})

# define role providers
controllers.arenas.provide(identifier: :mf_infrastructure, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :mf_infrastructure, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws)
controllers.arenas.provide(identifier: :mf_infrastructure, role_identifier: :runtime, provider_identifier: :docker)

# bind a blueprint to the arena
controllers.arenas.bind(identifier: :mf_infrastructure, blueprint_identifier: 'aws-example-1')

# ------------------------------------------------------------------------------
# stage some blueprints in the mf_infrastructure arena
controllers.arenas.stage(identifier: :mf_infrastructure)

# # build images for the arena
# controllers.arenas.build(identifier: :mf_infrastructure, threaded: false)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :mf_infrastructure, threaded: false)
