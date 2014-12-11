require 'vips'

class CreatePyramidTiff < CreateImageDerivative
  PYRAMID_TIFF_OPTIONS = {
    compression: :jpeg,
    quality: 80,
    multi_res: :pyramid,
    tile_size: [256, 256]
  }

  private

    def create_derivative!
      tiff_writer.write(target_filepath)
    end

    def tiff_writer
      @tiff_writer ||= VIPS::TIFFWriter.new(source_image, PYRAMID_TIFF_OPTIONS)
    end

end
