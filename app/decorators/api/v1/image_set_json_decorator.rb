module API
  module V1
    class ImageSetJsonDecorator < Draper::Decorator
      def id
        h.api_v1_image_url(object.relative_filepath)
      end

      def image
        API::V1::ImageJsonDecorator.new(object.original)
      end

      def name
        object.basename.to_s
      end

      def derivatives
        @derivatives ||= build_derivatives
      end

      private
        def build_derivatives
          object.derivatives.collect{|derivative| API::V1::DerivativeJsonDecorator.new(derivative)}
        end
    end
  end
end
