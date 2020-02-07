require_relative '../spaces/model'

module OsPackage
  class OsPackage < ::Spaces::Model

    relation_accessor :context

    def subspace_path
      "#{context.subspace_path}/#{image_space_path}"
    end

    def image_space_path
      context.image_space_path
    end

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
