class Api::ImagesController < ApplicationController
  rescue_from Image::ImageNotFound, with: :image_not_found
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
    @image = Image.find(params[:image_path])

    render json: {image: ImageJsonFormatter.new(@image)}
  end

  private

    def image_not_found(exception)
      render json: {error: exception.message}, status: 404
    end
end
