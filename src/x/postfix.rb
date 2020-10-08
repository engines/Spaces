require_relative 'universe'

def descriptor
  @descriptor ||= Spaces::Descriptor.new(
    repository: 'https://github.com/MarkRatjens/engines-postfix.git',
    identifier: 'smtp',
    branch: 'image-packing'
  )
end
