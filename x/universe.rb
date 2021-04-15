$LOAD_PATH.unshift(Pathname.new(__dir__).parent.join('lib').expand_path)

require 'spaces'

def universe; @u ||= Universe.new ;end

def clear
  @u,
  @publication,
  @blueprint,
  @resolution,
  @pack,
  @arena,
  @provisions = nil
end
