require './api/helpers/packing'

# Create commit
post '/packing/:identifier/commit' do
  pack = universe.packs.by(params[:identifier])
  universe.packs.commit(pack)
  packing_commit_for(params[:identifier]).to_json
end

# Show commit
get '/packing/:identifier/commit' do
  packing_commit_for(params[:identifier]).to_json
end
