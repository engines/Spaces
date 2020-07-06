require_relative '../texts/file_text'
require_relative '../releases/release'
require_relative 'stanzas'

module Terraform
  class Terraform < ::Releases::Release
    include Stanzas

    class << self
      def stanza_lot
        files_in(:stanzas).map { |f| ::File.basename(f, '.rb') }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def resolutions; universe.resolutions.all ;end

    def content
      stanzas.flatten.compact.join("\n")
    end

    def components; files_for(:modules) ;end

    def files_for(directory)
      environment_file_names_for(directory).map do |t|
        text_class.new(origin: t, directory: directory, context: self)
      end
    end

    def environment_file_names_for(directory)
      Dir[environment_directory_for(directory)].reject { |f| ::File.directory?(f) }
    end

    def environment_directory_for(directory)
      File.join(File.dirname(__FILE__), "environment/#{directory}/**/*")
    end

    def text_class; Texts::FileText ;end

    def file_name; identifier ;end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.memento if descriptor
    end

  end
end
