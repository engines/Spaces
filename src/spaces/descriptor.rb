require_relative 'model'

module Spaces
  class Descriptor < ::Spaces::Model

    def identifier; struct.identifier ||= root_identifier ;end
    def root_identifier; repository.split('/').last.split('.').first if repository ;end

    def branch; struct.branch ||= 'master' ;end
    def protocol; struct.protocol ||= extension ;end
    def git?; protocol == 'git' ;end
    def extraction; struct.extraction ||= extension ;end

    def extracted_path; struct.extracted_path ||= identifier ;end
    def destination_path; [home_app_path, struct.destination_path].compact.join('/') ;end
    def home_app_path; '/home/app' ;end
    def basename; ::File.basename(repository) ;end
    def extension; repository&.split('.')&.last ;end

    def initialize(args)
      self.struct = args[:struct] || OpenStruct.new(args)
    end

    def to_s
      [repository, branch, identifier].compact.join(' ')
    end

  end
end
