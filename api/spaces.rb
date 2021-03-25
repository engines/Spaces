require 'pathname'

$:.unshift(Pathname.new(__FILE__).parent.join('lib').expand_path)

require 'spaces'

def universe
  @universe ||= Universe.new
end
