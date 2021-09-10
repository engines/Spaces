module Streaming
  class Space < Spaces::Space
    include Spaces::Filing

    class << self
      def default_model_class
        Stream
      end
    end

    def import(input, &block)
      tail_file(import_out_filepath, &block)
    end

    def export(input, &block)
      tail_file(export_out_filepath, &block)
    end

    def build(input, &block)
      tail_file(build_out_filepath(input), &block)
    end

    def init(input, &block)
      tail_file(init_out_filepath(input), &block)
    end

    def plan(input, &block)
      tail_file(plan_out_filepath(input), &block)
    end

    def apply(input, &block)
      tail_file(apply_out_filepath(input), &block)
    end

    def import_out_filepath
      universe.publications.path.join('import.out')
    end

    def export_out_filepath
      universe.publications.path.join('export.out')
    end

    def build_out_filepath(input)
      universe.packs.path.join(*input[:identifier].split('::'), 'build.out')
    end

    def init_out_filepath(input)
      universe.arenas.path.join(input[:identifier], 'init.out')
    end

    def plan_out_filepath(input)
      universe.arenas.path.join(input[:identifier], 'plan.out')
    end

    def apply_out_filepath(input)
      universe.arenas.path.join(input[:identifier], 'apply.out')
    end

  end
end
