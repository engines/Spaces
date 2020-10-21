def resolution; @resolution ||= universe.resolutions.by(descriptor.identifier) ;end

def save_resolution; universe.resolutions.save(resolution) ;end
