module Commands
  class Space < ::Spaces::PathSpace

    class << self
      def default_model_class = Command
    end

    def writing_path_for(command) =
      path.join("#{command.space.identifier}")

  end
end
