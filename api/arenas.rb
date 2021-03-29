# Index arenas
get '/arenas' do
  universe.arenas.identifiers.to_json
end

# Show arena
get '/arenas/:arena_identifier' do
  universe.arenas.by("#{params[:arena_identifier]}").to_json
end

# Create an arena
post '/arenas' do
  arena = Arenas::Arena.new(params[:arena].to_h.transform_keys(&:to_sym))
  universe.arenas.save(arena)
  associated_arena = arena.associated
  universe.arenas.save(associated_arena)
  bootstrap_descriptor = Spaces::Descriptor.new(params[:bootstrap].to_h.transform_keys(&:to_sym))
  universe.publications.import(bootstrap_descriptor, force: true)
  bootstrap = universe.blueprints.by(bootstrap_descriptor.identifier)
  bootstrap_resolution = bootstrap.with_embeds.resolved_in(associated_arena)
  universe.resolutions.save(bootstrap_resolution)
  bootstrapped_arena = associated_arena.bootstrapped_with(bootstrap_descriptor.identifier)
  universe.arenas.save(bootstrapped_arena)
  arena_with_embeds = bootstrapped_arena.with_embeds
  universe.arenas.save(arena_with_embeds)
  resolution_identifier = "#{arena.identifier}/#{bootstrap_descriptor.identifier}"
  resolution = universe.resolutions.by(resolution_identifier)
  provisions = resolution.provisioned
  universe.provisioning.save(provisions)
  arena.identifier.to_json
end

# Delete arena
delete '/arenas/:identifier' do
  arena = universe.arenas.by(params[:identifier])
  universe.arenas.delete(arena)
  nil.to_json
end
