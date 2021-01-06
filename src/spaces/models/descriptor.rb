require 'addressable/uri'

require_relative 'model'

module Spaces
  class Descriptor < Model

    delegate(identifier: :struct)

    def root_identifier
      basename.to_s
    end

    def branch
      struct.branch ||= 'main'
    end

    def protocol
      struct.protocol ||= extension
    end

    def git?
      protocol == 'git'
    end

    def basename
      add_ext(rpath.basename, "")
    end

    def extension
      rpath.extname
    end

    def initialize(args)
      @repository = Addressable::URI.parse(args[:repository])

      self.struct = args[:struct] || OpenStruct.new(args)
      self.struct.identifier ||= root_identifier
    end

    def to_s
      [@repository.to_s, branch, identifier].compact.join(' ')
    end

    private

    def rpath
      @rpath ||= Pathname((@repository) ? @repository.path : "")
    end
  end
end
