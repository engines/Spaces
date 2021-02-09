def resolution; @resolution ||= blueprint.with_embeds.resolved_in(arena) ;end

def save_resolution; universe.resolutions.save(resolution) ;end
