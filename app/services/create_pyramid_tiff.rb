require 'vips'

class CreatePyramidTiff < CreateImageDerivative
  PYRAMID_TIFF_OPTIONS = {
    compression: :jpeg,
    Q: 80,
    pyramid: true,
    tile_width: 256,
    tile_height: 256
  }

  private

    def create_derivative!
      source_image.tiffsave(target_filepath, PYRAMID_TIFF_OPTIONS)
    end

    # def tiff_writer
    #   @tiff_writer ||= Vips::Image.new(source_image)
    # end

end
