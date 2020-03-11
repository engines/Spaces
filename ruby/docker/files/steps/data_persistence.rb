require_relative 'requires'

module Docker
  module Files
    module Steps
      class DataPersistence < Step

        def product
          %Q(
          /scripts/persistent_dirs.sh enginetest:#{home_app_path}/fresh_dir_perm_test enginetest:#{home_app_path}/home_persistent enginetest:/usr/local/local_persist enginetest:/home/home_dir/home_dir_persist enginetest:#{home_app_path}/test_package_dest/test_persist_dir data:#{home_app_path}/persistent && \
          /scripts/persistent_files.sh enginetest:app/fresh_test_persistent_file data:app/test_package_dest/test_persist_file
          )
        end

      end
    end
  end
end
