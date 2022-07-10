module Targeting
  module Targeting

    def target_from(space, identifier: context_identifier) =
      targeter_for(space, identifier).emission

    def targeter_for(space, identifier) =
      targeter_class.new(identifier, space)

    def targeter_class = Targeter

  end
end
