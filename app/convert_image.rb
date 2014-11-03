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
      "vips im_vips2tiff #{image.realpath} #{image.converted_realpath}:jpeg:80,tile:256x256,pyramid"
    end

end
