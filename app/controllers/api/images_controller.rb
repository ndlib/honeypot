class Api::ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  Mime::Type.register "image/png", :png
  Mime::Type.register "image/jpeg", :jpg

  def new
  end

  def create
    @image = AddImage.call(params)
    render json: {image: ImageJsonFormatter.new(@image)}
  end

  def show
    @image = Image.new(params[:image_path])
    respond_to do |format|
      format.json { render json: {image: ImageJsonFormatter.new(@image)} }
      format.jpg { send_file @image.original_realpath }
    end
  end
end
