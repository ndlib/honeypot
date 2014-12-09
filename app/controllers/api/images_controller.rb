class Api::ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    @image = AddImage.new(params)
    if @image.upload!
      render json: {image: ImageJsonFormatter.new(@image.image_object)}
    else
      render json: {error: @image.errors}, status: 500
    end
  end

  def show
    @image = Image.new(params[:image_path])
    respond_to do |format|
      format.json { render json: {image: ImageJsonFormatter.new(@image)} }
      format.jpg { send_file @image.original_filepath }
    end
  end
end
