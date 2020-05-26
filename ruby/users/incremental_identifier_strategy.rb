
module Users
  module IncrementalIdentifierStrategy

    def next_identifier
      (first_time? ? seed_identifier : next_running_identifier).tap do |id|
        i = id.to_i
        save_new_next(identifier: i += 1)
      end
    end

    def first_time?
      !::File.exist?(writing_name_for(increment_file_name))
    end

    def next_running_identifier
      ::File.read(writing_name_for(increment_file_name)).strip
    end

    def save_new_next(identifier:)
      ::File.write(writing_name_for(increment_file_name), "#{identifier}")
    end

    def seed_identifier; '100000' ;end

    def increment_file_name; 'next' ;end
  end
end
