require_relative '../texts/file_text'
require_relative '../releases/release'
require_relative '../releases/schema'
require_relative 'providers/provider'

module Provisioning
  class Provisions < ::Releases::Release

    class << self
      def schema_class; ::Releases::Schema ;end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    def containers
      resolutions_for_containers.map { |r| r.containers.all }.flatten.compact
    end

    def resolutions_for_containers
      resolutions.select(&:has_containers?)
    end

    def resolutions; universe.resolutions.all ;end

    def bindings
      resolutions_with_bindings.map { |r| r.bindings.all }.flatten.compact
    end

    def resolutions_with_bindings
      resolutions.select { |r| r.respond_to? :bindings }
    end

    def providers
      [explicit_providers, providers_implied_in_containers].flatten.uniq(&:uniqueness)
    end

    def explicit_providers
      accumulation_map[:providers]&.map(&:all) || []
    end

    def providers_implied_in_containers
      containers.map do |b|
        universe.provisioning.providers.by(struct: b.struct, division: self)
      end
    end

    def accumulation_map
      @accumulation_map ||= schema_keys.inject({}) do |m, k|
        m.tap { m[k] = resolutions.map { |r| r.division_map[k] }.compact }
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

    def initialize(descriptor)
      self.struct = OpenStruct.new
      self.struct.descriptor = descriptor&.memento if descriptor
    end

  end
end
