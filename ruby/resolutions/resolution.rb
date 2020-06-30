require_relative '../spaces/model'
require_relative 'schema'
require_relative 'release'

module Resolutions
  class Resolution < Release

    delegate(
      resolution: :itself,
      resolutions: :universe,
      [:identifier, :home_app_path] => :descriptor
    )

    alias_accessor :blueprint, :predecessor

    def components
      [terraforms].flatten
    end

    def terraforms; resolutions_for(:terraform) ;end

    def resolutions_for(directory)
      resolutions.unresolved_names_for(directory).map do |t|
        text_class.new(origin: t, directory: directory, context: self)
      end
    end

    def text_class; Texts::FileText ;end

    def initialize(struct: nil, blueprint: nil, descriptor: nil)
      self.blueprint = blueprint
      self.struct = duplicate(struct || blueprint&.struct)
      self.struct.descriptor = self.struct.descriptor&.merge(descriptor&.memento) || descriptor&.memento
    end

  end
end
