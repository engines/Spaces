repository = 'https://github.com/v2Blueprints/powerdns'

# import blueprint
controllers.publishing.import(model: {repository: repository}, threaded: false)

# setup arena for orchestration
controllers.arenas.create(model: {identifier: :infrastructure})
controllers.arenas.build_from(identifier: :infrastructure, image_identifier: :base_debian)
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :packing, provider_identifier: :docker_local)
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :orchestration, provider_identifier: :docker_compose_local)
controllers.arenas.provide(identifier: :infrastructure, role_identifier: :runtime, provider_identifier: :docker_local)
controllers.arenas.stage(identifier: :infrastructure, blueprint_identifier: :powerdns)

# orchestrate arena
controllers.arenas.apply(identifier: :infrastructure, threaded: false)
