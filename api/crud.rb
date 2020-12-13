require './api/helpers/crud'

# Index a space
get '/:space' do
  universe.send(params[:space]).identifiers.to_json
end

# Show a member from a space
get '/:space/:identifier' do
  universe.send(params[:space]).by(params[:identifier]).to_json
end

# Create a member in a space
post '/:space' do
  space = universe.send(params[:space])
  key = member_key_for(params[:space])
  klass = member_class_for(params[:space])
  struct = params[key].to_struct
  object = klass.new(struct: struct)
  space.save(object)
  object.to_json
end

# Update a member in a space
put '/:space/:identifier' do
  space = universe.send(params[:space])
  struct = JSON.parse(request.body.read).to_struct
  klass = member_class_for(space)
  object = klass.new(struct: struct)
  space.save(object)
  object.to_json
end

# Delete a member from a space
delete '/:space/:identifier' do
  space = universe.send(params[:space])
  object = space.by(params[:identifier])
  space.delete(arena)
  nil.to_json
end
