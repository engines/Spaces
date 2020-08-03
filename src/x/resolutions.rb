require_relative '../resolutions/resolution'

def resolution; @resolution ||= universe.resolutions.by(descriptor) ;end

def save_resolution; universe.resolutions.save(resolution) ;end
