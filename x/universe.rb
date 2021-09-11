$LOAD_PATH.unshift(Pathname.new(__dir__).parent.join('lib').expand_path)

require 'spaces'

def universe
  @u ||= ::Spaces::UniverseSpace.new.universe
end
