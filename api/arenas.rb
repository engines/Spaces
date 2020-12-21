require './api/helpers/topology'

# Show provisioning for an arena.
get '/arenas/:identifier/provisioning' do
  universe.provisioning.provisioning_for(
    arena_identifier: params[:identifier]
  ).to_json
end

# Perform an action (:init, :plan or :apply) on an arena.
post '/arenas/:identifier/:action' do
  arena = universe.arenas.by(params[:identifier])
  result = universe.arenas.send(params[:action], arena)
  raise result.error if result.is_a? Recovery::Trace
  "Successfully performed '#{params[:action]}'.".to_json
end

# Data for arena topology graphs
get '/arenas/:identifier/topology/mesh' do
  resolution_mesh_for(params[:identifier]).to_json
end
get '/arenas/:identifier/topology/tree' do
  resolution_tree_for(params[:identifier]).to_json
end
