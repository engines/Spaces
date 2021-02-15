def descriptor; @descriptor ;end

def import; universe.publications.import(descriptor, force: true); end

def publication
  @publication ||= universe.publications.by(descriptor.identifier)
end

def save_publication; universe.publications.save(publication) ;end
