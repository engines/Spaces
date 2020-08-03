require_relative '../universal/space'
require_relative '../spaces/descriptor'
require_relative 'blueprints'
require_relative 'resolutions'
require_relative 'packing'
require_relative 'provisioning'


def universe; @u ||= Universal::Space.new ;end

def clear
  @u,
  @blueprint,
  @resolution,
  @pack,
  @provisions = nil
end
