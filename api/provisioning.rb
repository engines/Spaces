# Create provisions
post '/provisioning/:arena_identifier/:resolution_identifier' do
  arena = universe.arenas.by(params[:arena_identifier])
  resolution = universe.resolutions.by(params[:resolution_identifier])
  universe.provisioning.save(
    Provisioning::Provisions.new(
      arena: arena,
      resolution: resolution,
    )
  )
end
