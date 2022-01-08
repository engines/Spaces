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

# save installations for the arena
controllers.arenas.install(identifier: :database)

# resolve the arena
controllers.arenas.resolve(identifier: :database)

# save all packs for the arena
controllers.arenas.pack(identifier: :database)

# provision the arena
controllers.arenas.provision(identifier: :database)

# # build packs for the arena
# controllers.arenas.build(identifier: :database)
#
# # apply provisions for arena
# controllers.arenas.apply(identifier: :database)

# #call create milestone scripts on a container for a given consumer
# controllers.servicing.execute(milestone: :create, identifier: 'database::mariadb', consumer_identifier: 'development::phpmyadmin')
