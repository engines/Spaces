require_relative 'production'

module Installations
  class Subdivision < Production

    relation_accessor :context

    delegate(
      [:installation, :subspace_path, :build_script_path] => :context
    )

    def initialize(struct:, context:)
      self.struct = struct
      self.context = context
    end

  end
end
