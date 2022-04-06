# load the code!
# require './x/controllers'

# ------------------------------------------------------------------------------

# save some providers
controllers.providing.create(model: {identifier: :docker_local, qualifier: :docker})
controllers.providing.create(model: {identifier: :docker_compose_local, qualifier: :docker_compose})
controllers.providing.create(model: {identifier: :terraform_local, qualifier: :terraform})
controllers.providing.create(model: {identifier: :power_dns_local, qualifier: :power_dns})
