# Data for system utilisation graphs.
# TODO: Stream live data from monitoring API.
get '/metrics/network' do
  File.read('./api/dummydata/network/vector.js')
end
get '/metrics/network/matrix' do
  File.read('./api/dummydata/network/matrix.js')
end
