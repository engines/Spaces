repository = 'https://github.com/v2Blueprints/powerdns'

# import blueprint
controllers.publishing.import(model: {repository: repository}, verbose: false).to_json
blueprint_identifier = controllers.publishing.identify(model: {repository: repository}).result
# sleep 1 # prepare the output file
# controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: blueprint_identifier)


# setup arena for orchestration
controllers.arenas.create(model: {identifier: :infrastructure}).to_json
controllers.arenas.build_from(identifier: :infrastructure, image_identifier: :base_debian).to_json
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :packing, provider_identifier: :docker).to_json
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :orchestration, provider_identifier: :docker_compose).to_json
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :runtime, provider_identifier: :docker).to_json
controllers.arenas.bind(identifier: :infrastructure, blueprint_identifier: :powerdns).to_json

# stage arena
controllers.arenas.stage(identifier: :infrastructure).to_json

# orchestrate arena
# controllers.arenas.apply(identifier: :infrastructure, verbose: false)
result = controllers.arenas.apply(identifier: :infrastructure, background: true).result
result.to_json
controllers.streaming.tail(space: :arenas, stream_identifier: :executing, identifier: :infrastructure, timestamp: result[:timestamp], callback: callback).to_json
