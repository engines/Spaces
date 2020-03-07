require_relative '../installations/collaborator'

module Users
  class User < Installations::Collaborator

    def identifier
      struct.identifier
    end

    def file_path
      identifier
    end

    def default
      @default ||= OpenStruct.new(data_uid: '2222', data_gid: '3333')
    end

  end
end
