# load the code!
# require './x/common/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :docker_compose, qualifier: :docker_compose})
