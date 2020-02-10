require_relative 'requires'

module Docker
  module Files
    module Steps
      class DataPersistence < Step

        def content
          %Q(
          /scripts/persistent_dirs.sh enginetest:/home/app/fresh_dir_perm_test enginetest:/home/app/home_persistent enginetest:/usr/local/local_persist enginetest:/home/home_dir/home_dir_persist enginetest:/home/app/test_package_dest/test_persist_dir data:/home/app/persistent && \
          /scripts/persistent_files.sh enginetest:app/fresh_test_persistent_file data:app/test_package_dest/test_persist_file
          )
        end

      end
    end
  end
end
