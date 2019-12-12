require 'open-uri'
require_relative '../space'

module Persistence
  module Uri
    class Space < ::Framework::Space
      # The dimensions in which resources exist

      def import(descriptor)
        d = if nullify_ssl?
          open(descriptor.url, { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE })
        else
          open(url)
        end

        IO.copy_stream(d, descriptor.value)
      rescue Resolv::ResolvError => e
        ::Framework::Error.new(e)
      rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
        ::Framework::Error.new(e)
      ensure
        d.close unless d.nil?
      end

      def nullify_ssl?
        File.exist?("#{path}/nullifySSL")
      end

    end
  end
end
