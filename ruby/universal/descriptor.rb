require_relative '../framework/model'

module Universal
  class Descriptor < ::Framework::Model

    attr_accessor :value,
      :identifier,
      :space

    def identifier
      value ? value.split('/').last.split('.').first : super
    end

    def url
      "#{space.path}/#{identifier}"
    end

  end
end
