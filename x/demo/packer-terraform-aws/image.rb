# load the code!
# require './x/common/controllers'

# ------------------------------------------------------------------------------

# import blueprint to build a base image
result = controllers.publishing.import(model: {repository: 'https://github.com/EnginesAWS/python'}, background: true).result
result.to_json
controllers.streaming.tail(space: :publications, stream_identifier: :importing, identifier: :python, timestamp: result[:timestamp], callback: callback).to_json

# ------------------------------------------------------------------------------

# save a basic arena with default associations
controllers.arenas.create(model: {identifier: :base}).to_json

# ------------------------------------------------------------------------------

# specify an image to build blueprints from
controllers.arenas.build_from(identifier: :base, image_identifier: :'python:3.8-slim-buster').to_json

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker}).to_json

# define packing providers
controllers.arenas.provide(identifier: :base, role_identifier: :packing, provider_identifier: :docker).to_json
controllers.arenas.provide(identifier: :base, role_identifier: :runtime, provider_identifier: :docker).to_json

# ------------------------------------------------------------------------------

# bind a base blueprint to the arena
controllers.arenas.bind(identifier: :base, blueprint_identifier: :'python').to_json

# stage the arena for the bindings -- should not orchestrate!
controllers.arenas.stage(identifier: :base).to_json

# # build images for the arena
result = controllers.arenas.build(identifier: :base, background: true).result
result.to_json
controllers.streaming.tail(space: :arenas, stream_identifier: :building, identifier: :base, timestamp: result[:timestamp], callback: callback).to_json
