# load the code!
# require './x/common/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# import some blueprints
controllers.publishing.import(model: {repository: 'https://github.com/MarkRatjens/vm'}, verbose: true)

# save a basic applications arena
controllers.arenas.create(model: {identifier: :vm})

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :docker_compose, qualifier: :docker_compose})

# define role providers
controllers.arenas.provide(identifier: :vm, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :vm, role_identifier: :orchestration, provider_identifier: :docker_compose)
controllers.arenas.provide(identifier: :vm, role_identifier: :runtime, provider_identifier: :docker)

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :vm, image_identifier: :debian_debian)

# ------------------------------------------------------------------------------
# bind blueprints to the arena
controllers.arenas.bind(identifier: :vm, blueprint_identifier: :vm)

# stage some blueprints in the applications arena
controllers.arenas.stage(identifier: :vm)

# build images for the arena
controllers.arenas.build(identifier: :vm)

# bring up containers for arena
controllers.arenas.apply(identifier: :vm)
