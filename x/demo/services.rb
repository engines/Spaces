repositories = [
  'https://github.com/v2Blueprints/mariadb',
  'https://github.com/v2Blueprints/wap'
]
blueprint_identifiers = []

# import blueprints
repositories.each do |repository|
  controllers.publishing.import(model: {repository: repository})
  blueprint_identifier = controllers.publishing.identify(model: {repository: repository}).result
  blueprint_identifiers.push(blueprint_identifier)
  sleep 1
  controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: blueprint_identifier)
end

# setup arena for orchestration
controllers.arenas.create(model: {identifier: :services})
controllers.arenas.build_from(identifier: :services, image_identifier: :base_debian)
controllers.arenas.provide(identifier: :services, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :services, role_identifier: :orchestration, provider_identifier: :docker_compose)
controllers.arenas.provide(identifier: :services, role_identifier: :runtime, provider_identifier: :docker)

# bind some arenas
controllers.arenas.connect(identifier: :services, other_identifier: :infrastructure)

# bind some blueprints
blueprint_identifiers.each do |blueprint_identifier|
  controllers.arenas.stage(identifier: :services, blueprint_identifier: blueprint_identifier)
end

# orchestrate arena
controllers.arenas.apply(identifier: :services)
sleep 1
controllers.streaming.tail(space: :arenas, stream_identifier: :executing, identifier: :services)
