require 'open-uri'
require 'resolv'
require_relative '../space'

module Persistence
  module Uri
    class Space < ::Framework::Space
      # The dimensions in which resources exist

      def encloses?(descriptor)
        File.exist?(file_name_for(descriptor))
      end

      def by(descriptor)
        f = File.open(file_name_for(descriptor), 'r')
        c = f.read
        f.close
        c
      end

      def file_name_for(descriptor)
        "#{path}/#{descriptor.basename}"
      end

      def import(descriptor)
        d = if nullify_ssl?
          open(descriptor.value, { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE })
        else
          open(descriptor.value)
        end

        IO.copy_stream(d, "#{path}/#{descriptor.basename}")
      # rescue Resolv::ResolvError => e
      #   ::Framework::Error.new(e)
      # rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
      #   ::Framework::Error.new(e)
      ensure
        d.close unless d.nil?
      end

      def nullify_ssl?
        File.exist?("#{path}/nullifySSL")
      end

    end
  end
end
