require_relative '../images/image'
require_relative 'release'

module Resolutions
  class Resolution < Release

    delegate(
      resolution: :itself,
      resolutions: :universe,
      home_app_path: :descriptor
    )

    alias_accessor :blueprint, :predecessor

    def image_name
      image&.name
    rescue NoMethodError
      image_class.default_name
    end

    def image_class; Images::Image ;end

    def components
      [image_components, container_components].flatten
    end

    def image_components; resolutions_for(:image) ;end
    def container_components; resolutions_for(:container) ;end

    def resolutions_for(directory)
      [
        resolutions.unresolved_names_for(directory),
        blueprint_file_names_for(directory)
      ].flatten.compact.map do |t|
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
