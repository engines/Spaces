def import; universe.blueprints.import(descriptor); end

def blueprint
  @blueprint ||=
    begin
      universe.blueprints.by(descriptor.identifier)
    rescue Errno::ENOENT => e
      just_print_the_error(__FILE__, __LINE__, e)
      import
    end
end

def save_blueprint; universe.blueprints.save(blueprint) ;end
