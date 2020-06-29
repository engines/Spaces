require_relative '../releases/division'
require_relative 'repository'

module Repositories
  class Repositories < ::Releases::Division

    def subdivision_class
      Repository
    end

  end
end
