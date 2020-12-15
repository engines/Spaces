# Import a member into a space. Such as import a blueprint.
post '/import' do
  space = params[:space]
  descriptor = Spaces::Descriptor.new(params[:descriptor])
  object = universe.send(space).import(descriptor)
  raise object.error if object.is_a? Recovery::Trace
  object.to_json
end
