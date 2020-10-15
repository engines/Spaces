module Spaces
  class Descriptor < ::Spaces::Model

    def identifier; struct.identifier ||= root_identifier ;end
    def root_identifier; repository.split('/').last.split('.').first if repository ;end

    def branch; struct.branch ||= 'main' ;end
    def protocol; struct.protocol ||= extension ;end
    def git?; protocol == 'git' ;end
    def extraction; struct.extraction ||= extension ;end

    def extracted_path; struct.extracted_path ||= identifier ;end
    def basename; Pathname.new(repository).basename ;end
    def extension; repository&.split('.')&.last ;end

    def initialize(args)
      self.struct = args[:struct] || OpenStruct.new(args)
    end

    def to_s
      [repository, branch, identifier].compact.join(' ')
    end

  end
end
