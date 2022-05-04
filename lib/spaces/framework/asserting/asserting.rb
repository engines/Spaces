require_relative 'errors'

module Spaces
  module Asserting

    def insist; affirm(precondition) ;end
    def assure; affirm(postcondition) ;end
    def enforce; affirm(invariant) ;end

    def affirm(clauses)
      (raise ::Spaces::Errors::FailedAffirmation, clauses) if failed?(clauses)
    end

    def failed?(clauses)
      [clauses.values].flatten.uniq.include?(false)
    end

    def precondition; {} ;end
    def postcondition; {} ;end
    def invariant; {} ;end

  end
end
