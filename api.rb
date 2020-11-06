require 'sinatra'
require 'byebug'

require_relative 'src/universe'

set show_exceptions: false

before do
  @universe = Universe.new
end

before do
  content_type 'application/json'
end

error do |e|
  content_type :text
  e.full_message.tap { |message| logger.error(message) }
end

def object(space, identifier)
  @universe.send(space).by(identifier)
end

def descriptor_for(description)
  Spaces::Descriptor.new(description)
end

# Environment

get '/environment' do
  {
    build_scripts: Packing::Pack.script_type_choices.map{|script| {script => Packing::Pack.script_choices_names(script)}}.inject(:merge)
  }.to_json
end

# Import

post '/import' do
  space = params[:space]
  descriptor = descriptor_for(params[:descriptor])
  object = @universe.send(space).import(descriptor)
  raise object.error if object.is_a? Recovery::Trace
  object.to_json
end

# Arenas

get '/arenas' do
  @universe.arenas.identifiers.to_json
end

get '/arenas/:identifier/provisions' do
  provision_identifiers = @universe.provisioning.identifiers(params[:identifier])
  provision_identifiers.map do |identifier|
    @universe.provisioning.by(identifier)
  end.to_json
end

post '/arenas' do
  arena = Arenas::Arena.new(struct: params[:arena].to_struct)
  @universe.arenas.save(arena)
  arena.to_json
end

get '/arenas/:identifier' do
  @universe.arenas.by(params[:identifier]).to_json
end

post '/arenas/:identifier/:action' do
  # :action can be init, plan or apply.
  arena = @universe.arenas.by(params[:identifier])
  result = @universe.arenas.send(params[:action], arena)
  raise result.error if result.is_a? Recovery::Trace
  "Successfully performed '#{params[:action]}'.".to_json
end

# Domains

get '/domains' do
  @universe.domains.identifiers.to_json
end

get '/domains/:identifier' do
  @universe.domains.by(params[:identifier]).to_json
end

post '/domains' do
  domain = Associations::Domain.new(struct: params[:domain].to_struct)
  @universe.domains.save(domain)
  domain.to_json
end

# Blueprints

get '/blueprints' do
  @universe.blueprints.identifiers.to_json
end

post '/blueprints' do
  blueprint = Blueprinting::Blueprint.new(struct: params[:blueprint].to_struct)
  @universe.blueprints.save(blueprint)
  blueprint.to_json
end

get '/blueprints/:identifier' do
  @universe.blueprints.by(params[:identifier]).to_json
end

put '/blueprints/:identifier' do
  struct = JSON.parse(request.body.read).to_struct
  blueprint = Blueprinting::Blueprint.new(struct: struct)
  @universe.blueprints.save(blueprint)
  blueprint.to_json
end

delete '/blueprints/:identifier' do
  blueprint = @universe.blueprints.by(params[:identifier])
  @universe.blueprints.delete(blueprint)
  nil.to_json
end

# Resolutions

get '/resolutions' do
  @universe.resolutions.identifiers.to_json
end

post '/resolutions' do
  resolution = Resolving::Resolution.new(struct: params[:resolution].to_struct)
  @universe.resolutions.save(resolution)
  resolution.to_json
end

get '/resolutions/:identifier' do
  @universe.resolutions.by(params[:identifier]).to_json
end

get '/resolutions/:identifier/validity' do
  resolution = @universe.resolutions.by(params[:identifier])
  {}.tap do |result|
    result[:errors] = {
      incomplete_divisions: resolution.incomplete_divisions,
      } if resolution.incomplete_divisions.any?
    end.to_json
  end

put '/resolutions/:identifier' do
  struct = JSON.parse(request.body.read).to_struct
  resolution = Resolving::Resolution.new(struct: struct)
  @universe.resolutions.save(resolution)
  resolution.to_json
end

delete '/resolutions/:identifier' do
  resolution = @universe.resolutions.by(params[:identifier])
  @universe.resolutions.delete(resolution)
  nil.to_json
end

# Packs

get '/packs' do
  @universe.packing.identifiers.to_json
end

post '/packs' do
  pack = Packing::Pack.new(struct: params[:pack].to_struct)
  @universe.packing.save(pack)
  pack.to_json
end

get '/packs/:identifier' do
  @universe.packing.by(params[:identifier]).to_json
end

post '/packs/:identifier/build' do
  pack = @universe.packing.by(params[:identifier])
  @universe.packing.commit(pack).to_json
  build = YAML.load_file("/opt/spaces/Universe/PackingSpace/#{params[:identifier]}/commit/output.yaml")
  {
    log: build.stdout
  }.to_json
end

get '/packs/:identifier/build' do
  build = YAML.load_file("/opt/spaces/Universe/PackingSpace/#{params[:identifier]}/commit/output.yaml")
  {
    log: build.stdout
  }.to_json
rescue Errno::ENOENT
  {
    log: "\e[1;31mUnbuilt\e[0m"
  }.to_json
end

delete '/packs/:identifier' do
  pack = @universe.packing.by(params[:identifier])
  @universe.packing.delete(pack)
  nil.to_json
end

# Provisions

get '/provisions' do
  @universe.provisioning.identifiers.to_json
end

post '/provisions' do
  provision = Provisioning::Provisions.new(
    struct: params[:provisions].to_struct)
  @universe.provisioning.save(provision)
  provision.to_json
end

get '/provisions/:arena_identifier/:resolution_identifier' do
  @universe.provisioning.by(
    "#{params[:arena_identifier]}/#{params[:resolution_identifier]}"
  ).to_json
end

delete '/provisions/:arena_identifier/:resolution_identifier' do
  provision = @universe.provisioning.by(
    "#{params[:arena_identifier]}/#{params[:resolution_identifier]}"
  )
  @universe.provisioning.delete(provision)
  nil.to_json
end

# System

get '/metrics/network' do
  File.read('./dummydata/network/vector.js')
end

get '/metrics/network/matrix' do
  File.read('./dummydata/network/matrix.js')
end

get '/topology' do
  nodes = [{id: 'system'}]
  edges = []
  @universe.resolutions.all.each do |resolution|
    nodes.push({id: resolution.identifier})
    edges.push({source: 'system', target: resolution.identifier})
    resolution.binding_descriptors.each do |binding|
      edges.push({source: resolution.identifier, target: binding.identifier})
    end
  end
  {
    nodes: nodes,
    edges: edges
  }.to_json
end
