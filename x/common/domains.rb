# load the code!
# require './x/common/controllers'

# ------------------------------------------------------------------------------

# save some domains
controllers.domains.create(model: {identifier: 'engines.org'})
controllers.domains.create(model: {identifier: 'engines.com'})
controllers.domains.create(model: {identifier: 'engines.online'})
controllers.domains.create(model: {identifier: 'engines.tv'})
controllers.domains.create(model: {identifier: :localhost})
