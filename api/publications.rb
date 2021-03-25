# Index publications
get '/publications' do
  universe.publications.identifiers.to_json
end

# Show publication
get '/publications/:blueprint_identifier' do
  universe.publications.by(params[:blueprint_identifier]).to_json
end

# Delete publication
delete '/publications/:blueprint_identifier' do
  publication = universe.publications.by(params[:blueprint_identifier])
  universe.publications.delete(publication)
  nil.to_json
end

# Import a blueprint.
post '/publications/import' do
  descriptor = Spaces::Descriptor.new(
    params[:descriptor]
    .to_h
    .transform_keys(&:to_sym)
    .delete_if{|k, v| v.empty?}
  )
  universe.publications.import(descriptor).to_json
end
