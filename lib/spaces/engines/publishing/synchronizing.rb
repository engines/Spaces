module Publishing
  module Synchronizing

    def synchronize_with(other_space, identifier)
      identifier.tap do |i|
        other_space.by(i).tap do |m|
          save(m.globalized)
          synchronize_auxiliaries_for(other_space, m)
        end
      end
    end

    protected

    def synchronize_auxiliaries_for(other_space, model)
      model.auxiliary_files.each  { |d| synchronize_auxiliaries(other_space, model, d) }
      model.auxiliary_folders.each { |d| synchronize_auxiliaries(other_space, model, d) }
    end

    def synchronize_auxiliaries(other_space, model, segment)
      "#{segment}".tap do |s|
        other_space.path_for(model).join(s).tap do |p|
          FileUtils.cp_r(p, path_for(model)) if p.exist?
        end
      end
    end

  end
end
