module Domains
  module Bucket

    def pgsql_host
      'pgsql.engines.internal'
    end

    def mysql_host
      'mysql.engines.internal'
    end

    def mongo_host
      'mongo.engines.internal'
    end

    def internal_domain
      'engines.internal'
    end

    def smtp_host
      'smtp.engines.internal'
    end

    def default_domain
      # prefs = SystemPreferences.new()
      # prefs.default_domain
    end

    def internal_domain
      'engines.internal'
    end

    # where ssh goes
    def mgmt_host
      # FixME read docker0 ip or cmd line option
      '172.17.0.1'
    end

    # where ssh goes
    def system_ip
      # FixME read docker0 ip or cmd line option
      ENV['SYSTEM_IP']
    end

    # docker interface addres
    def docker_ip
      # FixME read docker0 ip or cmd line option
      '172.17.0.1'
    end

  end
end
