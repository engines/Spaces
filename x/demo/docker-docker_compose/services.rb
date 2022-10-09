repositories = [
  'https://github.com/v2Blueprints/mariadb',
  'https://github.com/v2Blueprints/wap'
]
blueprint_identifiers = []

# import blueprints
repositories.each do |repository|
  controllers.publishing.import(model: {repository: repository}, verbose: false).to_json
  blueprint_identifier = controllers.publishing.identify(model: {repository: repository}).result
  blueprint_identifiers.push(blueprint_identifier).to_json
  # sleep 1
  # controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: blueprint_identifier)
end

# setup arena for orchestration
controllers.arenas.create(model: {identifier: :services}).to_json
controllers.arenas.build_from(identifier: :services, image_identifier: :base_debian).to_json
controllers.arenas.provide(identifier: :services, role_identifier: :packing, provider_identifier: :docker).to_json
controllers.arenas.provide(identifier: :services, role_identifier: :orchestration, provider_identifier: :docker_compose).to_json
controllers.arenas.provide(identifier: :services, role_identifier: :runtime, provider_identifier: :docker).to_json

# bind some arenas
controllers.arenas.connect(identifier: :services, other_identifier: :infrastructure).to_json

# bind some blueprints
blueprint_identifiers.each do |blueprint_identifier|
  controllers.arenas.bind(identifier: :services, blueprint_identifier: blueprint_identifier).to_json
end

# stage arena
controllers.arenas.stage(identifier: :services).to_json

# orchestrate arena
controllers.arenas.apply(identifier: :services, verbose: false).to_json
