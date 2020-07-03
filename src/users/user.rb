require_relative '../releases/division'

module Users
  class User < ::Releases::Division

    def identifier; struct.identifier ;end

    def to_s; identifier ;end

  end
end
