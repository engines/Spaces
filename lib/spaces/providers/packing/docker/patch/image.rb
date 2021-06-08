class Docker::Image

  class << self

    private

    # A method to build the config header and merge it into the
    # headers sent by build_from_dir.
    def build_headers(creds=nil)
      credentials = creds || Docker.creds || {}
      config_header = build_config_header(credentials)

      headers = { 'Content-Type'      => 'application/tar',
                  'Transfer-Encoding' => 'chunked' }
      headers = headers.merge(config_header) if config_header
      headers
    end

    def build_config_header(credentials)
      if credentials.is_a?(String)
        credentials = MultiJson.load(credentials, symbolize_keys: true)
      end

      header = MultiJson.dump(
        credentials[:serveraddress].to_s => {
          'username' => credentials[:username].to_s,
          'password' => credentials[:password].to_s,
          'email' => credentials[:email].to_s
        }
      )

      { 'X-Registry-Config' => Base64.urlsafe_encode64(header) }.merge(credentials)
    end
  end

end
