require_relative 'commissioning_interface'

module Providers
  module Docker
    class ServiceInterface < CommissioningInterface

      alias_method :service, :resolving_emission

      def execute_commands_for(milestone_name)
        wait_for
        wait_for(:startup)
        service.commands_for(milestone_name).map do |c|
          container.exec([c], env: service.parameters)
        end
      end

      def wait_for(milestone_name = '', timeout: 5)
        unless OS.mac?
          wait_for_proper_linux(milestone_name, timeout: timeout)
        else
          kludge_for_dev_macos(milestone_name, timeout: timeout)
        end
      end

      protected

      def wait_for_proper_linux(milestone_name = '', timeout: 5)
        require 'rb-inotify' # only works for linux!
        p = service.full_service_path.join("#{milestone_name}")
        Timeout::timeout(timeout) do
          while !p.exist?
            n = INotify::Notifier.new
            n.watch(p, :modify) { next }
            n.process
          end
        end
      rescue Timeout::Error
        n.close
        STDERR.puts("Timeout on wait for #{p}")
        p.exist? # catch race condition
      end

      def kludge_for_dev_macos(milestone_name = '', timeout: 5)
        p = service.full_service_path.join("#{milestone_name}")
        Timeout::timeout(timeout) do
          while !p.exist?
            sleep(1)
          end
        end
      rescue Timeout::Error
        STDERR.puts("Timeout on wait for #{p}")
        p.exist? # catch race condition
      end

    end
  end
end
