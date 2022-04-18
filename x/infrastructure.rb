# load the code!
# require './x/controllers'

# ------------------------------------------------------------------------------

# import infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/powerdns'}, threaded: false)

# ------------------------------------------------------------------------------
# save a providers arena for infrastructure use
controllers.arenas.create(model: {identifier: :infrastructure})

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :infrastructure, image_identifier: :base_debian)

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker_local, qualifier: :docker})
controllers.providing.create(model: {identifier: :docker_compose_local, qualifier: :docker_compose})
controllers.providing.create(model: {identifier: :terraform_local, qualifier: :terraform})
controllers.providing.create(model: {identifier: :power_dns, qualifier: :power_dns})

# define role providers
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :packing, provider_identifier: :docker_local)
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :orchestration, provider_identifier: :docker_compose_local)
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :runtime, provider_identifier: :docker_local)

# ------------------------------------------------------------------------------
# stage some blueprints in the infrastructure arena
controllers.arenas.stage(identifier: :infrastructure, blueprint_identifier: :powerdns)

# # build images for the arena
# controllers.arenas.build(identifier: :infrastructure, threaded: false)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :infrastructure, threaded: false)
