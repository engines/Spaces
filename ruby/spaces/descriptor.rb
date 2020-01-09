require_relative 'model'

module Spaces
  class Descriptor < ::Spaces::Model

    attr_accessor :value,
      :identifier,
      :branch

    def initialize(struct = nil)
      if struct
        self.value = struct.value
        self.identifier = struct.identifier
        self.branch = struct.branch
      end
    end

    def identifier
      @identifier ||= value&.split('/').last.split('.').first
    end

    def branch
      @branch ||= 'master'
    end

    def basename
      File.basename(value)
    end

    def extension
      value&.split('.')&.last
    end

  end
end
