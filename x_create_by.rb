require_relative './src/universe'
universe = Universe.new
identifier = 'test_app'
blueprint = Blueprinting::Blueprint.new(identifier: identifier)
universe.blueprints.save(blueprint)
universe.blueprints.by(identifier).to_json
universe.resolutions.by(identifier).to_json
universe.packing.by(identifier).to_json
universe.provisioning.by(identifier).to_json
