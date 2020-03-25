require_relative '../spaces/descriptor'
require_relative 'save'

def descriptor
  @descriptor ||= Spaces::Descriptor.new.tap do |m|
    m.value = 'https://github.com/MarkRatjens/mysqld.git'
  end
end
