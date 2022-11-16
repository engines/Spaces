# load the code!
# require './x/common/controllers'

# ------------------------------------------------------------------------------

# import infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/redmine'}, verbose: true)

# ------------------------------------------------------------------------------
# save an arena
controllers.arenas.create(model: {identifier: :redmine})

# define role providers
controllers.arenas.provide(identifier: :redmine, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :redmine, role_identifier: :orchestration, provider_identifier: :docker_compose)
controllers.arenas.provide(identifier: :redmine, role_identifier: :runtime, provider_identifier: :docker)

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :redmine, image_identifier: :debian_debian)

# ------------------------------------------------------------------------------

# bind a blueprint to the arena
controllers.arenas.bind(identifier: :redmine, blueprint_identifier: :redmine)

# ------------------------------------------------------------------------------
# stage some blueprints in the infrastructure arena
controllers.arenas.stage(identifier: :redmine)

# # build images for the arena
# controllers.arenas.build(identifier: :redmine, verbose: true)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :redmine, verbose: true)
