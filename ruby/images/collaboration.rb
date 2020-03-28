require_relative '../spaces/constantizing'

module Images
  module Collaboration
    include Spaces::Constantizing

    def script_lot
      self.class.script_lot
    end

    def scripts
      script_lot&.map { |s| class_for('Scripts', s).new(self) }
    end

    def build_script_path
      'build/scripts'
    end

  end
end
