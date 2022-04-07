# load the code!
require './x/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# import services blueprints
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/mariadb'}, threaded: false)
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/wap'}, threaded: false)

# ------------------------------------------------------------------------------
# save a services arena for common use
controllers.arenas.create(model: {identifier: :services})

# define providers for spaces roles
controllers.arenas.provide(identifier: :services, role_identifier: :packing, provider_identifier: :docker_local)
controllers.arenas.provide(identifier: :services, role_identifier: :orchestration, provider_identifier: :docker_compose_local)
controllers.arenas.provide(identifier: :services, role_identifier: :runtime, provider_identifier: :docker_local)

controllers.arenas.provide(identifier: :services, role_identifier: :dns, provider_identifier: :dns, resolution_identifier: 'infrastructure::powerdns')

# ------------------------------------------------------------------------------
# stage some blueprints in the services arena
controllers.arenas.stage(identifier: :services, blueprint_identifier: :mariadb)
controllers.arenas.stage(identifier: :services, blueprint_identifier: :wap)

# # build images for the arena
# controllers.arenas.build(identifier: :services, threaded: false)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :services, threaded: false)

# # call add milestone scripts on a container for a given consumer
# controllers.servicing.service(milestone: :add, identifier: 'database::mariadb', consumer_identifier: 'development::phpmyadmin')

# # start a container
# controllers.commissioning.start(identifier: 'services::mariadb')
