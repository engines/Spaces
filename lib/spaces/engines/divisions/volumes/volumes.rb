module Divisions
  class Volumes < ::Divisions::Divisible

    # def type
    #   "#{runtime_qualifier}/#{qualifier.singularize}" if in_blueprint?
    # end

    def struct_merged_with(other); super.uniq(&:source) ;end

  end
end
