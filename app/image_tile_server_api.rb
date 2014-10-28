class ImageTileServerApi < Sinatra::Base

  get '/' do
    'HEEELLLLLLLOOOOO!!!'
  end

  get '/test' do
    erb :test
  end

  run! if app_file == $0
end
