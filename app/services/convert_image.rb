require 'vips'

class ConvertImage
  attr_reader :image

  def self.call(image)
    new(image).convert!
  end

  def initialize(image)
    @image = image
  end

  def convert!
    create_pyramid_tiff!
  end

  private
    def source_filepath
      image.original_filepath
    end

    def pyramid_filepath
      image.pyramid_filepath
    end

    def create_pyramid_tiff!
      CreatePyramidTiff.call(source_filepath, pyramid_filepath)
    end

end
