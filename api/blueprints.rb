# List by recursive lookup of all blueprint dependencies.
get '/blueprints/:identifier/turtles' do
  (universe.blueprints.by(params[:identifier]).turtle_descriptors || [] ).map(&:identifier).to_json
end
