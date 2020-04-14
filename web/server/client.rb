module Server
  class Client < Base

    get '/app.js' do
      content_type :'application/javascript'
      concatenate 'web/client/**/*.js'
    end

    get '*' do
      erb :'index.html'
    end

    private

    def concatenate( source )
      Dir.glob( [ source ] ).select do |file|
        File.file?(file)
      end.sort do |a, b|
        a.count('/') <=> b.count('/')
      end.map do |file|
        File.read( file )
      end.join("\n")
    end

  end
end
