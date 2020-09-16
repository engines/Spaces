require_relative '../spaces/descriptor'
require_relative 'universe'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/MarkRatjens/Heycock.git',
    branch: 'spaces'
  )
end
