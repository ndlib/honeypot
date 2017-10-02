module API
  module V1
    class DerivativeJSONDecorator < Draper::Decorator
      delegate :width, :height, to: :image

      def thumbnail_type
        if pyramid?
          'dzi'
        else
          object.type
        end
      end

      def src
        src_url = image.src
        if pyramid?
          src_url = "#{src_url}"
        end
        src_url
      end

      def encoding_format
        if pyramid?
          'dzi'
        else
          image.encoding_format
        end
      end

      def image
        @image ||= API::V1::ImageJSONDecorator.new(object.image)
      end

      private

        def pyramid?
          object.type.to_sym == :pyramid
        end
    end
  end
end
