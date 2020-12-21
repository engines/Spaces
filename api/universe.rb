require 'pathname'

$:.unshift(Pathname.new(__FILE__).parent.join('src').expand_path)

require './src/universe'

def universe
  @universe ||= Universe.new
end
