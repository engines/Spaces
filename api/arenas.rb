# Perform an action (:init, :plan or :apply) on an arena.
post '/arenas/:identifier/:action' do
  arena = universe.arenas.by(params[:identifier])
  result = universe.arenas.send(params[:action], arena)
  raise result.error if result.is_a? Recovery::Trace
  "Successfully performed '#{params[:action]}'.".to_json
end
