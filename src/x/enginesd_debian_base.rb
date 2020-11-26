require_relative 'universe'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/MarkRatjens/enginesd_debian_base.git',
  )
end
