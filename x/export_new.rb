# load the code!
# require './x/controllers'

# destroy the universe
# universe.workspace.rmtree

# ------------------------------------------------------------------------------

# import just any blueprint
controllers.publishing.import(model: {repository: 'https://github.com/v2Blueprints/docker'})

# ------------------------------------------------------------------------------

# copy that blueprint to something that's unpublished
controllers.blueprinting.copy(identifier: :docker, new_identifier: :you_pick )

# add a user_key for exporting
controllers.user_keys.create(model: {domain: 'deliberately_awful', username: 'fictitious', token: 'untrustworthy'})

# update a user_key
# controllers.user_keys.update(identifier: 'deliberately_awful::fictitious', model: {token: 'a little bit trustworthy', explanation: 'just because'})

# add a location for exporting that blueprint
controllers.locations.create(model: {repository: 'https://github.com/MarkRatjens/you_pick', key_identifier: 'deliberately_awful::fictitious'})

# ------------------------------------------------------------------------------

# export that blueprint to a fresh repo
controllers.publishing.export(identifier: :you_pick, model: {message: 'you say'})
