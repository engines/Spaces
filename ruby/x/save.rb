require_relative '../universal/space'
require_relative '../resolutions/resolution'

def universe
  @u ||= Universal::Space.new
end

def import
  universe.blueprints.import(descriptor)
end

def blueprint
  @blueprint ||=
  begin
    universe.blueprints.by(descriptor)
  rescue Errno::ENOENT
    import
  end
end

def resolution
  @resolution ||= universe.resolutions.by(descriptor) || Resolutions::Resolution.new(blueprint: blueprint)
end

def clear
  @u = nil
  @blueprint = nil
  @resolution = nil
end

def save_image_subject
  universe.images.save(resolution.image_subject)
end

def save_resolution
  universe.resolutions.save(resolution)
end

def save_blueprint
  universe.blueprints.save(blueprint)
end
