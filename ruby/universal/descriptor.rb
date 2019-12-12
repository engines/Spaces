require_relative '../framework/model'

module Universal
  class Descriptor < ::Framework::Model

    attr_accessor :value,
      :identifier,
      :space

    def import
      space&.universal.persistence.import(self)
    end

    def identifier
      value&.split('/').last.split('.').first
    end

    def url
      "#{space&.path}/#{identifier}"
    end

    def extension
      value&.split('.')&.last
    end

  end
end

# /opt/engines/FrameworkModel/FrameworkModel/miniminal
