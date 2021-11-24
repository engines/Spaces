module Targeting
  module Targeting

    def emission_from(space)
      targeter_for(space).emission
    end

    def targeter_for(space)
      targeter_class.new(context_identifier, space)
    end

    def targeter_class; Targeter ;end

  end
end
