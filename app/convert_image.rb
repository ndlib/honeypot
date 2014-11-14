class ConvertImage
  attr_reader :image

  def self.call(image)
    new(image).convert!
  end

  def initialize(image)
    @image = image
  end

  def convert!
    `#{command}`
  end

  private

    def command
      "#{vips_command} im_vips2tiff #{image.original_realpath} #{image.realpath}:jpeg:80,tile:256x256,pyramid"
    end

    def vips_command
      ApiApplication.settings.vips_command
    end

end
