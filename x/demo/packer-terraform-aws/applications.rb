# ------------------------------------------------------------------------------

# import mf_infrastructure blueprints
result = controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/managed-functions'}, background: true).result
result.to_json
controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: :'managed-functions', timestamp: result[:timestamp], callback: callback).to_json
result = controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/startup-infrastructure'}, background: true).result
result.to_json
controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: :'startup-infrastructure', timestamp: result[:timestamp], callback: callback).to_json

# ------------------------------------------------------------------------------
# save a providers arena for mf_infrastructure use
controllers.arenas.create(model: {identifier: :applications}).to_json

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :applications, image_identifier: :base_python).to_json

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker}).to_json
controllers.providing.create(model: {identifier: :terraform, qualifier: :terraform}).to_json
controllers.providing.create(model: {identifier: :aws, qualifier: :aws, account_identifier: 910122582945, region: :'ap-southeast-2'}).to_json

# define role providers
controllers.arenas.provide(identifier: :applications, role_identifier: :packing, provider_identifier: :docker).to_json
controllers.arenas.provide(identifier: :applications, role_identifier: :orchestration, provider_identifier: :terraform, compute_identifier: :aws).to_json
controllers.arenas.provide(identifier: :applications, role_identifier: :runtime, provider_identifier: :docker).to_json

# bind blueprints to the arena
controllers.arenas.bind(identifier: :applications, blueprint_identifier: 'managed-functions').to_json
controllers.arenas.bind(identifier: :applications, blueprint_identifier: 'startup-infrastructure').to_json

# ------------------------------------------------------------------------------
# stage some blueprints in the mf_infrastructure arena
controllers.arenas.stage(identifier: :applications).to_json

# build images for the arena
result = controllers.arenas.build(identifier: :applications, background: true).result
result.to_json
controllers.streaming.tail(space: :arenas, stream_identifier: :building, identifier: :applications, timestamp: result[:timestamp], callback: callback).to_json

# bring up containers for arena
result = controllers.arenas.plan(identifier: :applications, background: true).result
result.to_json
controllers.streaming.tail(space: :arenas, stream_identifier: :plan, identifier: :applications, timestamp: result[:timestamp], callback: callback).to_json
