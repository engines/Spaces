require './api/helpers/crud'

# Index a space
get '/:space' do
  universe.send(params[:space]).identifiers.to_json
end

# Show a member from a space
get '/:space/*' do
  identifier = params[:splat][0]
  universe.send(params[:space]).by(identifier).to_json
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
put '/:space/*' do
  space = universe.send(params[:space])
  struct = JSON.parse(request.body.read).to_struct
  klass = member_class_for(params[:space])
  debugger
  object = klass.new(struct: struct)
  space.save(object)
  object.to_json
end

# Delete a member from a space
delete '/:space/*' do
  identifier = params[:splat][0]
  space = universe.send(params[:space])
  object = space.by(identifier)
  space.delete(object)
  nil.to_json
end
