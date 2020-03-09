require_relative '../installations/user'

module Users
  class User < Installations::User

    def identifier
      struct.identifier
    end

    def file_path
      identifier
    end

    def default
      @default ||= OpenStruct.new(data_uid: '2222', data_gid: '3333')
    end

    def as_installation_user
      installation_user_class.new(struct: struct, installation:installation)
    end

    def installation_user_class
      Installations::User
    end

  end
end
