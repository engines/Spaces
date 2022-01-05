module Divisions
  class Milestone < ::Divisions::Subdivision

    delegate(
      context_identifier: :division
    )

  end
end
