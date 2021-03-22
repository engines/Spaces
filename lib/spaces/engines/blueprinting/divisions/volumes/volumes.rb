module Divisions
  class Volumes < ::Divisions::Divisible

    def type
      "#{runtime_type}/#{qualifier.singularize}" if runtime_type
    end

    def struct_with(other); super.uniq(&:source) ;end

  end
end
