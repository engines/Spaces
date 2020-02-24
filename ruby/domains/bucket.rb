module Domains
  module Bucket

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
