repository = 'https://github.com/v2Blueprints/debian'
image_identifier = :debian

# import a base image blueprint
controllers.publishing.import(model: {repository: repository}, background: false)
blueprint_identifier = controllers.publishing.identify(model: {repository: repository}).result
# sleep 1 # prepare the output file
# controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: blueprint_identifier, callback: callback)

# setup an arena for building
controllers.arenas.create(model: {identifier: :base})
controllers.arenas.build_from(identifier: :base, image_identifier: :debian)
controllers.arenas.provide(identifier: :base, role_identifier: :packing, provider_identifier: :docker)
controllers.arenas.provide(identifier: :base, role_identifier: :runtime, provider_identifier: :docker)
controllers.arenas.bind(identifier: :base, blueprint_identifier: blueprint_identifier)

# stage arena
controllers.arenas.stage(identifier: :base)

# controllers.arenas.resolve(identifier: :base)
# controllers.arenas.pack(identifier: :base)

# # build the pack
pack_identifier = "base::#{blueprint_identifier}"
controllers.packing.build(identifier: pack_identifier, background: false)
# build_args = controllers.packing.build(identifier: pack_identifier, background: true)[:result]
# controllers.streaming.tail(space: :packs, stream_identifier: :building, identifier: pack_identifier, timestamp: build_args[:timestamp])
