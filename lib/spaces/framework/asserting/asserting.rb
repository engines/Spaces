require_relative 'errors'

module Spaces
  module Asserting

    def insist = affirm(precondition)
    def assure = affirm(postcondition)
    def enforce = affirm(invariant)

    def affirm(clauses)
      (raise ::Spaces::Errors::FailedAffirmation, clauses) if failed?(clauses)
    end

    def failed?(clauses) = [clauses.values].flatten.uniq.include?(false)

    def precondition = {}
    def postcondition = {}
    def invariant = {}

  end
end
