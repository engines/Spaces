repositories = [
  'https://github.com/v2Blueprints/phpmyadmin',
]
blueprint_identifiers = []

# import blueprints
repositories.each do |repository|
  controllers.publishing.import(model: {repository: repository}, verbose: true)
  blueprint_identifier = controllers.publishing.identify(model: {repository: repository}).result
  blueprint_identifiers.push(blueprint_identifier)
  # sleep 1
  # controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: blueprint_identifier)
end

# setup arena for orchestration
controllers.arenas.create(model: {identifier: :applications})
controllers.arenas.build_from(identifier: :applications, image_identifier: :base_debian)
controllers.arenas.provide(identifier: :applications, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :applications, role_identifier: :orchestration, provider_identifier: :docker_compose)
controllers.arenas.provide(identifier: :applications, role_identifier: :runtime, provider_identifier: :docker)

# bind some arenas
controllers.arenas.connect(identifier: :applications, other_identifier: :services)

# bind some blueprints
blueprint_identifiers.each do |blueprint_identifier|
  controllers.arenas.bind(identifier: :applications, blueprint_identifier: blueprint_identifier)
end

# stage arena
controllers.arenas.stage(identifier: :applications)

# orchestrate arena
result = controllers.arenas.apply(identifier: :applications, background: true).result
controllers.streaming.tail(space: :arenas, stream_identifier: :executing, identifier: :applications, timestamp: result[:timestamp], callback: callback)
