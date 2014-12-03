require 'vips'

class ConvertImage
  PYRAMID_TIFF_OPTIONS = {
    compression: :jpeg,
    quality: 80,
    multi_res: :pyramid,
    tile_size: [256, 256]
  }
  attr_reader :image

  def self.call(image)
    new(image).convert!
  end

  def initialize(image)
    @image = image
  end

  def convert!
    tiff_writer.write(output_path)
  end

  private

    def source_path
      image.original_realpath
    end

    def output_path
      image.realpath
    end

    def source_image
      @source_image ||= VIPS::Image.new(source_path)
    end

    def tiff_writer
      @tiff_writer ||= VIPS::TIFFWriter.new(source_image, PYRAMID_TIFF_OPTIONS)
    end

end