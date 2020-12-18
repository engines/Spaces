require_relative 'universe'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/v2Blueprints/node-red.git'
  )
end
