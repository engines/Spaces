module Locating
  class Location < ::Spaces::Descriptor

    class << self
      def features; super + [:key_identifier] ;end
    end

    delegate(user_keys: :universe)

    def repository_url
      unless user_key
        super
      else
        super.gsub('//', "//#{user_key&.qualifier}")
      end
    end

    def user_key
      @user_key ||= user_keys.exist_then_by(struct.key_identifier)
    end

    def well_formed?
      repository
    end

  end
end
