require_relative '../universe'


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
