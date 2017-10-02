require 'vips'

class CreatePyramidTiff < CreateImageDerivative
  PYRAMID_TIFF_OPTIONS = {
    compression: :jpeg,
    Q: 80,
    pyramid: true,
    tile_width: 256,
    tile_height: 256,
  }

  private

    def create_derivative!
      method = "vips dzsave #{source_image.filename} #{target_filepath}"
      `#{method}`
      FileUtils.rm_rf("#{target_filepath}_files")
    end
end
