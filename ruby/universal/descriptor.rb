require_relative '../spaces/model'

module Universal
  class Descriptor < ::Spaces::Model

    attr_accessor :value,
      :identifier,
      :branch

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
