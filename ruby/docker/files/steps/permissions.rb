require_relative 'requires'

module Docker
  module Files
    module Steps
      class Permissions < Step

        def content
          %Q(
          /scripts/recursive_write_permissions.sh test_package_dest/test_write_rec_dir && \
          /scripts/write_permissions.sh test_package_dest/test_write_file test_package_dest/test_write_dir test_package_dest/test_write_rec_dir && \
          )
        end

      end
    end
  end
end
