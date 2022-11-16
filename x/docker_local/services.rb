# load the code!
# require './x/common/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# import services blueprints
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/mariadb'}, verbose: true)
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/wap'}, verbose: true)

# ------------------------------------------------------------------------------
# save a services arena for common use
controllers.arenas.create(model: {identifier: :services})

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :docker_compose, qualifier: :docker_compose})

# define role providers
controllers.arenas.provide(identifier: :services, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :services, role_identifier: :orchestration, provider_identifier: :docker_compose)
controllers.arenas.provide(identifier: :services, role_identifier: :runtime, provider_identifier: :docker)

# ------------------------------------------------------------------------------

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :services, image_identifier: :debian_debian)

# bind some blueprints to the arena
controllers.arenas.bind(identifier: :services, blueprint_identifier: :mariadb)
controllers.arenas.bind(identifier: :services, blueprint_identifier: :wap)

# ------------------------------------------------------------------------------
# stage the arena
controllers.arenas.stage(identifier: :services)

# # build images for the arena
controllers.arenas.build(identifier: :services, verbose: true)
#
# # bring up containers for arena
controllers.arenas.apply(identifier: :services, verbose: true)

# # call add milestone scripts on a container for a given consumer
# controllers.servicing.service(milestone: :add, identifier: 'database::mariadb', consumer_identifier: 'development::phpmyadmin')

# # start a container
# controllers.commissioning.start(identifier: 'services::mariadb')
