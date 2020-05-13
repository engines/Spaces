require_relative 'release'

module Projects
  class Project < Release

    delegate(
      identifier: :descriptor,
      projects: :universe
    )

    def file_names_for(directory)
      projects.file_names_for(directory, descriptor)
    end

    def initialize(descriptor)
      self.struct = OpenStruct.new
      self.struct.descriptor = descriptor&.memento
    end

  end
end
