module Associations
  class Tenant < ::Emissions::Division

    def default_struct
      OpenStruct.new(identifier: 'engines')
    end

  end
end
