require_relative '../releases/release'

module Packing
  class Pack < ::Releases::Release

    delegate(
      [:identifier, :images, :repository_name, :anchor_descriptors] => :resolution
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :keys, :schema_keys

    def export; struct_for(images.all.map(&:export)) ;end
    def memento; super.merge(struct_for(images.all.map(&:commit))) ;end

    def struct_for(images)
      OpenStruct.new(
        builders: images.tap do |i|
          i.each { |s| s.delete_field(:scripts) }
        end
      )
     end

    def components
      [scripts, injections].flatten
    end

    def scripts; files_for(:scripts) ;end

    def files_for(directory)
      file_names_for(directory).map do |t|
        text_class.new(origin: t, directory: directory, context: self)
      end
    end

    def file_names_for(directory)
      Dir[directory_for(directory)].reject { |f| ::File.directory?(f) }
    end

    def directory_for(directory)
      File.join(File.dirname(__FILE__), "#{directory}/**/*")
    end

    def initialize(resolution)
      self.struct = struct_for(resolution.memento.images)
      self.resolution = resolution
    end

  end
end
