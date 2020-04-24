require_relative 'model'
require_relative 'descriptor_schema'

module Spaces
  class Descriptor < ::Spaces::Model

    class << self
      define_method (:schema_class) { DescriptorSchema }
    end

    define_method (:identifier) { struct.identifier ||= default_identifier }
    define_method (:default_identifier) { repository.split('/').last.split('.').first if repository }

    define_method (:branch) { struct.branch ||= 'master' }
    define_method (:protocol) { struct.protocol ||= extension }
    define_method (:git?) { protocol == 'git' }
    define_method (:extraction) { struct.extraction ||= extension }

    define_method (:extracted_path) { struct.extracted_path ||= identifier }
    define_method (:destination_path) { [home_app_path, struct.destination_path].compact.join('/') }
    define_method (:home_app_path) { '/home/app' }
    define_method (:basename) { File.basename(repository) }
    define_method (:extension) { repository&.split('.')&.last }

    def initialize(args)
      self.struct = args[:struct] || OpenStruct.new(args)
    end

  end
end
