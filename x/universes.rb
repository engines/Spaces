$LOAD_PATH.unshift(Pathname.new(__dir__).parent.join('lib').expand_path)

require 'spaces'

def universes
  @m ||= ::Universes::Multiverse.new
end

def universe = universes.universe
def cache = universes.cache
