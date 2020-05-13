require_relative '../releases/division'

module Users
  class User < ::Releases::Division

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps, :scripts

    def identifier
      struct.identifier
    end

    def default
      @default ||= OpenStruct.new(data_uid: '2222', data_gid: '3333')
    end

  end
end
