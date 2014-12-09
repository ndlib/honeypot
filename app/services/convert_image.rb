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
    verify_directory
    tiff_writer.write(output_path)
  end

  private
    def verify_directory
      dirname = File.dirname(output_path)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
    end

    def source_path
      image.original_filepath
    end

    def output_path
      image.pyramid_filepath
    end

    def source_image
      @source_image ||= VIPS::Image.new(source_path)
    end

    def tiff_writer
      @tiff_writer ||= VIPS::TIFFWriter.new(source_image, PYRAMID_TIFF_OPTIONS)
    end

end
