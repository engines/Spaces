# import mf_infrastructure blueprints
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/managed-functions'}, verbose: false).to_json
controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/startup-infrastructure'}, verbose: false).to_json

# ------------------------------------------------------------------------------
# save a providers arena for mf_infrastructure use
controllers.arenas.create(model: {identifier: :mxr}).to_json

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :mxr, image_identifier: :base_python).to_json

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker}).to_json
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform}).to_json
controllers.providing.create(model: {identifier: :aws, qualifier: :aws, account_identifier: 910122582945, region: :'ap-southeast-2'}).to_json

# define role providers
controllers.arenas.provide(identifier: :mxr, role_identifier: :packing, provider_identifier: :docker).to_json
controllers.arenas.provide(identifier: :mxr, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws).to_json
controllers.arenas.provide(identifier: :mxr, role_identifier: :runtime, provider_identifier: :docker).to_json

# bind blueprints to the arena
controllers.arenas.bind(identifier: :mxr, blueprint_identifier: 'managed-functions').to_json
controllers.arenas.bind(identifier: :mxr, blueprint_identifier: 'startup-infrastructure').to_json

# ------------------------------------------------------------------------------
# stage some blueprints in the mf_infrastructure arena
controllers.arenas.stage(identifier: :mxr).to_json

print controllers.resolving.index(arena_identifier: :mxr).result.map(&:identifier).to_yaml
# print controllers.resolving.show(identifier: :'mxr::longitude').to_json

# build images for the arena
controllers.arenas.build(identifier: :mxr, verbose: false).to_json

# Init and Plan arena
# Test three ways of viewing output: verbose false, verbose true and background true
controllers.arenas.init(identifier: :mxr, verbose: false).result
controllers.arenas.init(identifier: :mxr, verbose: true).result
result = controllers.arenas.init(identifier: :mxr, background: true).result
result.to_json
controllers.streaming.tail(space: :arenas, stream_identifier: :init, identifier: :mxr, timestamp: result[:timestamp], callback: callback).to_json

controllers.arenas.plan(identifier: :mxr, verbose: false).to_json
controllers.arenas.plan(identifier: :mxr, verbose: true).to_json
result = controllers.arenas.plan(identifier: :mxr, background: true).result
controllers.streaming.tail(space: :arenas, stream_identifier: :plan, identifier: :mxr, timestamp: result[:timestamp], callback: callback).to_json
