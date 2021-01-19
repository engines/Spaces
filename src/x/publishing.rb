def import; universe.publications.import(descriptor); end

def publication
  @publication ||=
    begin
      universe.publications.by(descriptor.identifier)
    rescue Errno::ENOENT => e
      import
    end
end

def save_publication; universe.publications.save(publication) ;end
