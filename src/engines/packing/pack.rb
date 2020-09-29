module Packing
  class Pack < ::Emissions::Emission

    class << self
      def composition_class; Composition ;end
    end

    delegate(
      [:identifier, :has?, :images, :binding_descriptors] => :resolution,
      script_file_names: :images
    )

    alias_accessor :resolution, :predecessor
    alias_method :context_identifier, :identifier
    alias_method :keys, :composition_keys

    def export; struct_for(images.all.map(&:export)) ;end
    def emit; super.merge(struct_for(images.all.map(&:commit))) ;end

    def struct_for(images)
      OpenStruct.new(
        builders: images&.tap do |i|
          i.each { |s| s.delete_field(:scripts) if s.dig(:scripts) }
        end
      )
    end

    def auxiliary_texts
      [nominated_scripts, injections].flatten
    end

    def nominated_scripts
      script_file_names.map do |t|
        interpolating_class.new(origin: "#{File.dirname(__FILE__)}/#{t}", directory: :scripts, division: self)
      end
    end

    def injections; resolution.files_for(:injections) ;end

    def files_for(directory)
      file_names_for(directory).map do |t|
        interpolating_class.new(origin: t, directory: directory, division: self)
      end
    end

    def file_names_for(directory)
      Dir[directory_for(directory)].reject { |f| ::File.directory?(f) }
    end

    def directory_for(directory)
      File.join(File.dirname(__FILE__), "#{directory}/**/*")
    end

    def initialize(resolution)
      self.struct = struct_for(resolution.emit.images)
      self.resolution = resolution
    end

  end
end
