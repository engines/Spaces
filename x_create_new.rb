require_relative './src/universe'
universe = Universe.new
# struct = {descriptor: {identifier: 'test_app'}}.to_struct
arena = Arenas::Arena.new(identifier: 'TestArena')
universe.arenas.save(arena).to_json
blueprint = Blueprinting::Blueprint.new(identifier: 'test_app')
universe.blueprints.save(blueprint).to_json
# resolution = Resolving::Resolution.new(identifier: 'test_app')
resolution = Resolving::Resolution.new(struct: {identifier: 'test_app'}.to_struct)
universe.resolutions.save(resolution).to_json
pack = Packing::Pack.new(resolution)
universe.packing.save(pack).to_json
provisions = Provisioning::Provisions.new(resolution: resolution, arena: arena)
universe.provisioning.save(provisions).to_json
