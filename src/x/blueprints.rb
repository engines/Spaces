def import; universe.blueprints.import(descriptor); end

def blueprint
  @blueprint ||=
  begin
    universe.blueprints.by(descriptor.identifier)
  rescue Errno::ENOENT
    import
  end
end

def save_blueprint; universe.blueprints.save(blueprint) ;end
