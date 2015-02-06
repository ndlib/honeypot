module API
  module V1
    class ImageJsonDecorator < Draper::Decorator
      def width
        distance(object.width)
      end

      def height
        distance(object.height)
      end

      def encoding_format
        object.type
      end

      def src
        File.join(h.root_url, Rails.configuration.settings.image_path, path)
      end

      private
        def distance(value)
          "#{value} px"
        end

        def path
          object.relative_filepath
        end
    end
  end
end
