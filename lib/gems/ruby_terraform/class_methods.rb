module RubyTerraform
  module ClassMethods

    # Redefine existing methods.
    #  Add config as argument for initializing command with configuration.

    def clean(opts = {}, config = {})
      Commands::Clean.new(**config).execute(opts)
    end

    def init(opts = {}, config = {})
      Commands::Init.new(**config).execute(opts)
    end

    def get(opts = {}, config = {})
      Commands::Get.new(**config).execute(opts)
    end

    def validate(opts = {}, config = {})
      Commands::Validate.new(**config).execute(opts)
    end

    def plan(opts = {}, config = {})
      Commands::Plan.new(**config).execute(opts)
    end

    def apply(opts = {}, config = {})
      Commands::Apply.new(**config).execute(opts)
    end

    def destroy(opts = {}, config = {})
      Commands::Destroy.new(**config).execute(opts)
    end

    def remote_config(opts = {}, config = {})
      Commands::RemoteConfig.new(**config).execute(opts)
    end

    def refresh(opts = {}, config = {})
      Commands::Refresh.new(**config).execute(opts)
    end

    def output(opts = {}, config = {})
      Commands::Output.new(**config).execute(opts)
    end

    def show(opts = {}, config = {})
      Commands::Show.new(**config).execute(opts)
    end

    def workspace(opts = {}, config = {})
      Commands::Workspace.new(**config).execute(opts)
    end

    def import(opts = {}, config = {})
      Commands::Import.new(**config).execute(opts)
    end

    def format(opts = {}, config = {})
      Commands::Format.new(**config).execute(opts)
    end
  end
end
