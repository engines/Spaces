# save some domains
controllers.domains.create(model: {identifier: 'example.com', primary: true})
controllers.domains.create(model: {identifier: :localhost})

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker})
controllers.providing.create(model: {identifier: :docker_compose, qualifier: :docker_compose})
