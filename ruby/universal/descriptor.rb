require_relative '../framework/model'

module Universal
  class Descriptor < ::Framework::Model

    attr_accessor :value,
      :identifier,
      :branch

    def identifier
      @identifier ||= value&.split('/').last.split('.').first
    end

    def basename
      File.basename(value)
    end

    def extension
      value&.split('.')&.last
    end

  end
end
