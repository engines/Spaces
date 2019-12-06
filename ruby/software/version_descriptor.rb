require_relative '../engines/model'
require_relative 'version'

module Software
  class VersionDescriptor < Engines::Model
    # AKA SoftwareListing?
    # Human-readable data minimally sufficient to identity & distinguish software product

    relation_accessor :software_version

  end
end
