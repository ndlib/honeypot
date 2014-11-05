require File.dirname(__FILE__) + '/add_image'
require File.dirname(__FILE__) + '/image_json_formatter'

class ApiApplication < Sinatra::Base

  get '/' do
    params.inspect
  end

  get '/test' do
    erb :test
  end

  post '/image' do
    image = AddImage.call(params)
    json :image => ImageJsonFormatter.new(image)
  end

  get '/image' do
    image = Image.find(File.join(params[:namespace], params[:filename]))
    json :image => ImageJsonFormatter.new(image)
  end

  run! if app_file == $0
end
