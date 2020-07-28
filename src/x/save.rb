require_relative '../universal/space'
require_relative '../spaces/descriptor'
require_relative '../resolutions/resolution'
require_relative '../packing/pack'
require_relative '../provisioning/provisions'

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
  @resolution ||= universe.resolutions.by(descriptor)
end

def pack
  @pack ||= Packing::Pack.new(resolution)
end

def provisions
  @provisions ||= Provisioning::Provisions.new(provisions_descriptor)
end

def provisions_descriptor
  @provisions_descriptor = Spaces::Descriptor.new(identifier: 'development')
end

def clear
  @u = nil
  @blueprint = nil
  @resolution = nil
end

def save_provisions
  universe.provisioning.save(provisions)
end

def save_pack
  universe.packing.save(pack)
end

def save_resolution
  universe.resolutions.save(resolution)
end

def save_blueprint
  universe.blueprints.save(blueprint)
end
