module Spaces
  module Git
    module Ssh

      def write_ssh_command
        ensure_space
        ssh_command_path.write(ssh_command)
      end

      def ssh_command_path
        Pathname.new(path.join('_ssh'))
      end

      def ssh_command
        "ssh -i #{ENV['PUBLIC_KEY_FILEPATH']} -o IdentitiesOnly=yes -o StrictHostKeyChecking=no"
      end

    end
  end
end
