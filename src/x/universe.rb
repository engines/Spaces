require_relative '../universe'
require_relative 'blueprints'
require_relative 'resolutions'
require_relative 'packing'
require_relative 'arenas'
require_relative 'provisioning'


def universe; @u ||= Universe.new ;end

def clear
  @u,
  @blueprint,
  @resolution,
  @pack,
  @arena,
  @provisions = nil
end
