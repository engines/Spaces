require_relative '../framework/model'

module Universal
  class Descriptor < ::Framework::Model

    attr_accessor :value,
      :identifier

    def identifier
      value ? value.split('/').last.split('.').first : super
    end

  end
end
