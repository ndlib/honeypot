require 'vips'

class ConvertImage
  attr_reader :image_set
  THUMBNAILS = {
    small: {height: 200},
    medium: {height: 800},
  }

  def self.call(image_set)
    new(image_set).convert!
  end

  def initialize(image_set)
    @image_set = image_set
  end

  def convert!
    create_pyramid_tiff!
    create_thumbnails!
  end

  private
    def source_filepath
      image_set.original_filepath
    end

    def create_pyramid_tiff!
      CreatePyramidTiff.call(source_filepath, image_set.pyramid_filepath)
    end

    def create_thumbnails!
      THUMBNAILS.each do |style, options|
        create_thumbnail!(style, options)
      end
    end

    def create_thumbnail!(style, options)
      CreateThumbnail.call(source_filepath, image_set.derivative_filepath(style), options)
    end

end
