module Divisions
  class Volumes < ::Divisions::Divisible

    def type
      "#{runtime_identifier}/#{qualifier.singularize}" if runtime_identifier
    end

    def struct_with(other); super.uniq(&:source) ;end

  end
end
