# Create provisions
post '/provisioning' do
  provisions = params[:provisions]
  arena_identifier = provisions[:arena_identifier]
  resolution_identifier = provisions[:resolution_identifier]
  arena = universe.arenas.by(arena_identifier)
  resolution = universe.resolutions.by(resolution_identifier)
  provisions = Provisioning::Provisions.new(
    arena: arena,
    resolution: resolution,
  )
  universe.provisioning.save(provisions)
  {
    identifier: provisions.identifier,
    arena_identifier: provisions.arena_identifier,
    resolution_identifier: provisions.resolution_identifier,
  }.to_json
end
