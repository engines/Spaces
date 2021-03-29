require './api/blueprints/icons'
require './api/blueprints/licenses'
require './api/blueprints/readmes'

# Index blueprints
get '/blueprints' do
  universe.blueprints.identifiers.to_json
end

# Show blueprint
get '/blueprints/:identifier' do
  universe.blueprints.by(params[:identifier]).to_json
end

# Delete blueprint
delete '/blueprints/:identifier' do
  blueprint = universe.blueprints.by(params[:identifier])
  universe.blueprints.delete(blueprint)
  nil.to_json
end

# Create blueprint
post '/blueprints' do
  struct = params[:blueprint].to_struct
  blueprint = Blueprinting::Blueprint.new(struct: struct)
  universe.blueprints.save(blueprint)
  blueprint.identifier.to_json
end

# Update blueprint
put '/blueprints/:identifier' do
  struct = JSON.parse(request.body.read).to_struct
  blueprint = Blueprinting::Blueprint.new(struct: struct)
  universe.blueprints.save(blueprint)
  blueprint.identifier.to_json
end

# List by recursive lookup of all blueprint dependencies.
# This route is used by GUI to preload blueprints for generating a topology for a blueprint.
get '/blueprints/:identifier/turtles' do
  (universe.blueprints.by(params[:identifier]).turtle_descriptors || [] ).map(&:identifier).to_json
end
