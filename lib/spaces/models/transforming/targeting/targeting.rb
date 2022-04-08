module Targeting
  module Targeting

    def target_from(space, identifier: context_identifier)
      targeter_for(space, identifier).emission
    end

    def targeter_for(space, identifier)
      targeter_class.new(identifier, space)
    end

    def targeter_class; Targeter ;end

  end
end
