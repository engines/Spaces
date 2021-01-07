def resolution = @resolution ||= universe.resolutions.by(descriptor.identifier)

def save_resolution = universe.resolutions.save(resolution)
