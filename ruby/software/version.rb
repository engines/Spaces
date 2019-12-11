require_relative '../framework/model'
require_relative 'software'
require_relative 'version_descriptor'

module Software
  class Version < ::Framework::Model
    # AKA Software Product Version
    # A software version to the level of minor version, patch and pre-release

    relation_accessor :software,
      :descriptor

    attr_accessor :version_number,
      :url,
      :extraction_command

  end
end
