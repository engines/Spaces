require_relative 'universe'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/MarkRatjens/apache.git',
  )
end
