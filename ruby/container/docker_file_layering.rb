module Container
  module DockerFileLayering
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def precedence
        @@precedence ||= [:initial, :variables, :adds, :volumes, :work_directories, :scripts, :final]
      end
    end

    def precedence
      self.class.precedence
    end

  end
end
