class ImageTileServerApi < Sinatra::Base

  get '/' do
    'HEEELLLLLLLOOOOO!!!'
  end

  get '/test' do
    erb :test
  end

  post '/add_image' do
    puts params.inspect
  end

  get '/image' do

  end

  run! if app_file == $0
end
