repository = 'https://github.com/v2Blueprints/powerdns'

# import blueprint
controllers.publishing.import(model: {repository: repository}, verbose: false)
blueprint_identifier = controllers.publishing.identify(model: {repository: repository}).result
# sleep 1 # prepare the output file
# controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: blueprint_identifier)


# setup arena for orchestration
controllers.arenas.create(model: {identifier: :infrastructure})
controllers.arenas.build_from(identifier: :infrastructure, image_identifier: :base_debian)
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :orchestration, provider_identifier: :docker_compose)
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :runtime, provider_identifier: :docker)
controllers.arenas.bind(identifier: :infrastructure, blueprint_identifier: :powerdns)

# stage arena
controllers.arenas.stage(identifier: :infrastructure)

# orchestrate arena
result = controllers.arenas.apply(identifier: :infrastructure, background: true).result
controllers.streaming.tail(space: :arenas, stream_identifier: :executing, identifier: :infrastructure, timestamp: result[:timestamp], callback: callback)
