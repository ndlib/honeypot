class Api::ImagesController < ApplicationController
  Mime::Type.register "image/png", :png
  Mime::Type.register "image/jpeg", :jpg

  def show
    @image = Image.new(params[:image_path])
    respond_to do |format|
      format.jpg { send_file @image.original_realpath }
    end
  end
end
