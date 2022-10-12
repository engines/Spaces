# load the code!
# require './x/common/controllers'

# ------------------------------------------------------------------------------

# import mf_infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/sura'}, verbose: true)
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/startup-infrastructure'}, verbose: true)

# ------------------------------------------------------------------------------
# save a providers arena for mf_infrastructure use
controllers.arenas.create(model: {identifier: :sura})

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :sura, image_identifier: :base_python)

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform})
controllers.providing.create(model: {identifier: :aws, qualifier: :aws, account_identifier: 910122582945, region: :'ap-southeast-2'})

# define role providers
controllers.arenas.provide(identifier: :sura, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :sura, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws)
controllers.arenas.provide(identifier: :sura, role_identifier: :runtime, provider_identifier: :docker)

# bind blueprints to the arena
controllers.arenas.bind(identifier: :sura, blueprint_identifier: 'sura')
controllers.arenas.bind(identifier: :sura, blueprint_identifier: 'startup-infrastructure')

# ------------------------------------------------------------------------------
# stage some blueprints in the mf_infrastructure arena
controllers.arenas.stage(identifier: :sura)

# # build images for the arena
# controllers.arenas.build(identifier: :sura, verbose: true)
#
# # bring up containers for arena
# controllers.arenas.apply(identifier: :sura, verbose: true)
