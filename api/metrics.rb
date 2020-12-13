# Data for system utilisation graphs.
# TODO: Stream live data from monitoring API.
get '/metrics/network' do
  File.read('./dummydata/network/vector.js')
end
get '/metrics/network/matrix' do
  File.read('./dummydata/network/matrix.js')
end
