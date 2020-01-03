require_relative '../spaces/model'
require_relative 'software'
require_relative 'version_descriptor'

module Software
  class Version < ::Spaces::Model
    # AKA Software Product Version
    # A software version to the level of minor version, patch and pre-release

    relation_accessor :software,
      :descriptor

    attr_accessor :version_number,
      :url,
      :extraction_command,
      :memory_usage

    def memory_usage
      instance_variable_get(:@memory_usage) || software.memory_usage
    end

  end
end
