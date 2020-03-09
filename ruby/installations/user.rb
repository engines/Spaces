require_relative 'collaborator'

module Installations
  class User < Collaborator

    def file_path
      "#{identifier}/#{self.class.identifier}"
    end

  end
end
