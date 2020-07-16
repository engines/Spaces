require_relative '../texts/file_text'
require_relative '../releases/release'
require_relative '../releases/schema'
require_relative 'stanzas'

module Terraform
  class Terraform < ::Releases::Release
    include Stanzas

    class << self
      def schema_class; ::Releases::Schema ;end

      def stanza_lot
        files_in(:stanzas).map { |f| ::File.basename(f, '.rb') }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def resolutions; universe.resolutions.all ;end

    def bindings
      resolutions_with_bindings.map { |r| r.bindings.all }.flatten.compact
    end

    def resolutions_with_bindings
      resolutions.select { |r| r.respond_to? :bindings }
    end

    def content
      declaratives.flatten.compact.join("\n")
    end

    def declaratives
      stanzas&.map(&:declaratives) || []
    end

    def division_map
      @division_map ||= schema.keys.inject({}) do |m, k|
        m[k] = resolutions.map { |r| r.division_map[k] }.compact
        m
      end
    end

    def components; files_for(:modules) ;end

    def files_for(directory)
      target_file_names_for(directory).map do |t|
        text_class.new(origin: t, directory: directory, context: self)
      end
    end

    def target_file_names_for(directory)
      Dir[target_directory_for(directory)].reject { |f| ::File.directory?(f) }
    end

    def target_directory_for(directory)
      File.join(File.dirname(__FILE__), "target/#{directory}/**/*")
    end

    def text_class; Texts::FileText ;end

    def file_name; identifier ;end

    def initialize(struct: nil, descriptor: nil)
      self.struct = duplicate(struct) || OpenStruct.new
      self.struct.descriptor = descriptor&.memento if descriptor
    end

  end
end
