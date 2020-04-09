require_relative 'user'
require_relative '../spaces/space'

module Users
  class Space < ::Spaces::Space

    def save_yaml(model)
      model.struct.identifier ||= next_identifier
      f = File.open("#{file_name_for(model.identifier)}.yaml", 'w')
      begin
        f.write(model.to_yaml)
      ensure
        f.close
      end
    end

    alias_method :save, :save_yaml

    def next_identifier
      (first_time? ? seed_identifier : next_running_identifier).tap do |id|
        increment(id)
      end
    end

    def first_time?
      !File.exist?(file_name_for('next'))
    end

    def next_running_identifier
      f = File.open(file_name_for('next'), 'r')
      begin
        f.read.strip
      ensure
        f.close
      end
    end

    def seed_identifier
      '100000'
    end

    def increment(identifier)
      f = File.open(file_name_for('next'), 'w+')
      begin
        i = identifier.to_i
        f.puts(i += 1)
      ensure
        f.close
      end
    end

    def file_name_for(identifier)
      ensure_space
      "#{path}/#{identifier}"
    end

    def default_model_class
      User
    end
  end
end
