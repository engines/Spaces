def blueprint
  @blueprint ||= universe.blueprints.by(descriptor.identifier)
end

def with_embeds; blueprint.with_embeds ;end


def save_blueprint; universe.blueprints.save(blueprint) ;end
