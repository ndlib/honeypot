require File.dirname(__FILE__) + '/add_image'

class ImageTileServerApi < Sinatra::Base

  get '/' do
    params.inspect
  end

  get '/test' do
    erb :test
  end

  post '/add_image' do
    image = AddImage.call(params)
    json :image => image
  end

  get '/image' do
    image = get_image(params)
    json :image => image
  end


  def get_image(params)
    Image.new(File.join(params[:namespace], params[:filename]))
  end

  run! if app_file == $0
end
