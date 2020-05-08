require_relative '../spaces/descriptor'
require_relative 'save'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/MarkRatjens/test_container.git',
    identifier: 'waverton',
    branch: 'multi_stage_build'
  )
end
