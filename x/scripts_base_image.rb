# load the code!
# require './x/controllers'

# ------------------------------------------------------------------------------

# import a bootstrappy blueprint
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/enginesd_debian_base', threaded: false})

# ------------------------------------------------------------------------------

# save a basic arena with default associations
controllers.arenas.create(model: {identifier: :base_arena})

# ------------------------------------------------------------------------------

# bind a base blueprint to the arena
controllers.arenas.bind(identifier: :base_arena, blueprint_identifier: :enginesd_debian_base)

# save installations for the bindings # NOW WHAT?
controllers.arenas.install(identifier: :base_arena)

# resolve the arena for the bindings # NOW WHAT?
controllers.arenas.resolve(identifier: :base_arena)

# ------------------------------------------------------------------------------

# save all packs for an arena
controllers.arenas.pack(identifier: :base_arena)

# build packs for the arena
controllers.arenas.build(identifier: :base_arena, threaded: false)
