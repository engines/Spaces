require_relative '../spaces/descriptor'
require_relative 'save'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/MarkRatjens/mysql.git',
    branch: 'spaces'
  )
end
