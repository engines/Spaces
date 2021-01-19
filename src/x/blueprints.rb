def blueprint
  @blueprint ||=
    begin
      universe.blueprints.by(descriptor.identifier)
    rescue Errno::ENOENT => e
      import
    end
end

def save_blueprint; universe.blueprints.save(blueprint) ;end
