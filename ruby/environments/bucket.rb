module Environments
  module Bucket

    def timezone_country_city
      # core.get_timezone
    end

    def timezone
      Time.now.getlocal.zone
    end

    def hrs_from_gmt
      m = Time.now.getlocal.gmt_offset
      if m == 0
        m.to_s
      else
        (m / 3600).to_s
      end
    end

  end
end
