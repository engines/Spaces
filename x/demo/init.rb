# save some domains
controllers.domains.create(model: {identifier: 'example.com'}).to_json
controllers.domains.create(model: {identifier: :localhost}).to_json

# save some providers
controllers.providing.create(model: {identifier: :docker, qualifier: :docker}).to_json
controllers.providing.create(model: {identifier: :docker_compose, qualifier: :docker_compose}).to_json
