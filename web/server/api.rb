module Server
  class Api < Base

    get '/:resources_name' do
      content_type :'application/json'
      { params[:resources_name] => [
        { id: 0, name: 'First' },
        { id: 1, name: 'Second' },
      ] }.to_json
    end

  end
end
