require 'vips'

class ConvertImage
  attr_reader :image
  THUMBNAILS = {
    small: {height: 200},
    medium: {height: 800},
  }

  def self.call(image)
    new(image).convert!
  end

  def initialize(image)
    @image = image
  end

  def convert!
    create_pyramid_tiff!
    create_thumbnails!
  end

  private
    def source_filepath
      image.original_filepath
    end

    def create_pyramid_tiff!
      CreatePyramidTiff.call(source_filepath, image.pyramid_filepath)
    end

    def create_thumbnails!
      THUMBNAILS.each do |style, options|
        create_thumbnail!(style, options)
      end
    end

    def create_thumbnail!(style, options)
      CreateThumbnail.call(source_filepath, image.derivative_filepath(style), options)
    end

end
