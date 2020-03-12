require 'open-uri'
require 'resolv'
require_relative '../../spaces/space'

module Outer
  module Uri
    class Space < ::Spaces::Space

      def encloses?(descriptor)
        File.exist?(read_name_for(descriptor))
      end

      def by(descriptor)
        f = File.open(read_name_for(descriptor), 'r')
        begin
          f.read
        ensure
          f.close
        end
      end

      def read_name_for(descriptor)
        ensure_space
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
      #   ::Spaces::Error.new(e)
      # rescue Timeout::Error, Errno::EINVAL, Errno::ECONNRESET, EOFError, Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError
      #   ::Spaces::Error.new(e)
      ensure
        d.close unless d.nil?
      end

      def nullify_ssl?
        File.exist?("#{path}/nullifySSL")
      end

    end
  end
end
