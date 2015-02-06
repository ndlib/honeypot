module API
  module V1
    class ImagesController < ApplicationController
      rescue_from ImageSet::ImageNotFound, with: :image_not_found
      skip_before_action :verify_authenticity_token
      before_action :set_access

      def new
      end

      def create
        @image = AddImage.new(params)
        if @image.upload!
          @image_set = API::V1::ImageSetJsonDecorator.new(@image.image_set)
          render action: :show, formats: [:json]
        else
          render json: {error: @image.errors}, status: 500
        end
      end

      def show
        image_set = ImageSet.find(params[:image_path])
        @image_set = API::V1::ImageSetJsonDecorator.new(image_set)
        expires_in 5.minutes, :public => true
        render formats: [:json]
      end

      private

        def image_not_found(exception)
          render json: {error: exception.message}, status: 404
        end

        def set_access
          response.headers["Access-Control-Allow-Origin"] = "*"
        end
    end
  end
end
