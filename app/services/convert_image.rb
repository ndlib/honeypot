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
    create_working_image!
    create_pyramid_tiff!
    create_thumbnails!
  end

  private
    def source_filepath
      image_set.original_filepath
    end

    def source_working_image
      image_set.working_filepath
    end

    def create_working_image!
      CreateThumbnail.call(source_filepath, source_working_image, working_copy_options)
    end

    def create_pyramid_tiff!
      CreatePyramidTiff.call(source_working_image, image_set.pyramid_filepath)
    end

    def create_thumbnails!
      THUMBNAILS.each do |style, options|
        create_thumbnail!(style, options)
      end
    end

    def create_thumbnail!(style, options)
      CreateThumbnail.call(source_working_image, image_set.thumbnail_filepath(style), options)
    end

    def source_image
      @source_image ||= VIPS::Image.new(source_filepath)
    end

    def source_width
      source_image.x_size
    end

    def source_height
      source_image.y_size
    end

    def working_copy_options
      out = {}
      if source_height > source_width
        out[:height] = source_height > 3999 ? 4000 : source_height
      else
        out[:width] = source_width > 3999 ? 4000 : source_width
      end
      out
    end

end
