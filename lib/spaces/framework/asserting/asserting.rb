require_relative 'errors'

module Spaces
  module Asserting

    def insist(assertion = nil) = affirm(assertion || precondition)
    def assure(assertion = nil ) = affirm(assertion || postcondition)
    def enforce(assertion = nil) = affirm(assertion || invariant)

    def affirm(clauses)
      (raise ::Spaces::Errors::FailedAssertion, clauses) if failed?(clauses)
    end

    def failed?(clauses) = [clauses.values].flatten.uniq.include?(false)

    def precondition = {}
    def postcondition = {}
    def invariant = {}

  end
end
