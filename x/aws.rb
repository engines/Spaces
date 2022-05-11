# load the code!
# require './x/controllers'

# ------------------------------------------------------------------------------

# import mf_infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/1-of-everything-AWS'}, threaded: false)

# ------------------------------------------------------------------------------
# save a providers arena for aws
controllers.arenas.create(model: {identifier: :aws})

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :mf_infrastructure, image_identifier: :base_debian)

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform})
controllers.providing.create(model: {identifier: :aws, qualifier: :aws, region: :'ap-southeast-2'})

# define role providers
controllers.arenas.provide(identifier: :aws, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :aws, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws)
controllers.arenas.provide(identifier: :aws, role_identifier: :runtime, provider_identifier: :docker)

# bind a blueprint to the arena
controllers.arenas.bind(identifier: :aws, blueprint_identifier: '1-of-everything-AWS')

# ------------------------------------------------------------------------------
# stage some blueprints in the mf_infrastructure arena
controllers.arenas.stage(identifier: :aws)

# # build images for the arena
# controllers.arenas.build(identifier: :mf_infrastructure, threaded: false)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :mf_infrastructure, threaded: false)
