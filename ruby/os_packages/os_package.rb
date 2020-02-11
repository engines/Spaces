require_relative '../spaces/model'

module OsPackages
  class OsPackage < ::Spaces::Model

    relation_accessor :context

    def subspace_path
      "#{context.subspace_path}/#{build_script_path}"
    end

    def build_script_path
      context.build_script_path
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
