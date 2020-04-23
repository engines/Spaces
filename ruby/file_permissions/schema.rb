
module FilePermissions
  module Schema

    def outline
      {
        file_permission: [(1..), { path: 1, recursive: 0 }]
      }
    end

  end
end
