module Divisions
  class Volumes < ::Divisions::SubclassDivisible

    def type
      "#{runtime_type}/#{qualifier.singularize}" if runtime_type
    end

    def struct_with(other); super.uniq(&:source) ;end

  end
end
