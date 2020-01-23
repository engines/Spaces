require_relative '../../steps/variables'

module Framework
  class Rails5
    class Variables < Framework::Variables

      def content
        [
          super,
          %Q(
            ENV WWW_DIR public
            ENV ContUser ruby
            ENV RAILS_ENV production

            ENV SECRET_KEY_BASE	#{SecureRandom.hex(128)}
            ENV RAILS_MASTER_KEY #{SecureRandom.hex(32)}
            ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

            ENV VOLDIR '/home/fs/files'
            ENV volume_name 'files'

            ENV DATABASE_URL $rails_flavor://$dbuser:$dbpasswd@$dbhost/$dbname
          )
        ]
      end

    end
  end
end
