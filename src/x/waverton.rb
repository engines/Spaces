require_relative 'universe'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/MarkRatjens/test_container.git',
    identifier: 'waverton',
    branch: 'hashicorp'
  )
end
