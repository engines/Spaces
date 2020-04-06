require_relative 'model'

module Spaces
  class Descriptor < ::Spaces::Model

    class << self
      def subspace_path_method
        :project_identifier
      end
    end

    attr_accessor :repository,
      :identifier,
      :local_identifier,
      :protocol,
      :branch,
      :extraction,
      :extracted_path,
      :destination_path

    def initialize(struct = nil)
      if struct
        self.repository = struct.repository
        self.local_identifier = struct.local_identifier
        self.protocol = struct.protocol
        self.branch = struct.branch
        self.extraction = struct.extraction
        self.extracted_path = struct.extracted_path
        self.destination_path = [home_app_path, struct.destination_path].compact.join('/')
      end
    end

    def identifier
      @identifier ||= local_identifier || project_identifier
    end

    def project_identifier
      repository.split('/').last.split('.').first if repository
    end

    def branch
      @branch ||= 'master'
    end

    def protocol
      @protocol ||= extension
    end

    def git?
      protocol == 'git'
    end

    def extraction
      @extraction ||= extension
    end

    def extracted_path
      @extracted_path ||= identifier
    end

    def home_app_path
      '/home/app'
    end

    def basename
      File.basename(repository)
    end

    def extension
      repository&.split('.')&.last
    end

  end
end
