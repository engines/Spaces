# load the code!
require './x/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# import a database blueprint
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/mariadb'}, threaded: false)

# ------------------------------------------------------------------------------
# save a database arena for common use
controllers.arenas.create(model: {identifier: :database})

# ------------------------------------------------------------------------------
# bind some blueprints to the database arena
controllers.arenas.bind(identifier: :database, blueprint_identifier: :mariadb)

# resolve the arena
controllers.arenas.resolve(identifier: :database)

# save all packs for the arena
controllers.arenas.pack(identifier: :database)

# provision the arena
controllers.arenas.provision(identifier: :database)

# # build images for the arena
# controllers.arenas.build(identifier: :database, threaded: false)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :database, threaded: false)

# # call add milestone scripts on a container for a given consumer
# controllers.servicing.service(milestone: :add, identifier: 'database::mariadb', consumer_identifier: 'development::phpmyadmin')

# # start a container
# controllers.commissioning.start(identifier: 'database::mariadb')
