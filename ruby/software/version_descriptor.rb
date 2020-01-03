require_relative '../spaces/model'
require_relative 'version'

module Software
  class VersionDescriptor < ::Spaces::Model
    # AKA SoftwareListing?
    # Human-readable data minimally sufficient to identity & distinguish software product

    relation_accessor :software_version

    attr_accessor :name

  end
end
