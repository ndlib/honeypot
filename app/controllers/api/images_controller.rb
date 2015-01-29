class Api::ImagesController < ApplicationController
  rescue_from ImageSet::ImageNotFound, with: :image_not_found
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    @image = AddImage.new(params)
    if @image.upload!
      @image_set = ImageSetJsonDecorator.new(@image.image_set)
      render action: :show, formats: [:json]
    else
      render json: {error: @image.errors}, status: 500
    end
  end

  def show
    image_set = ImageSet.find(params[:image_path])
    @image_set = ImageSetJsonDecorator.new(image_set)
    render formats: [:json]
  end

  private

    def image_not_found(exception)
      render json: {error: exception.message}, status: 404
    end
end
