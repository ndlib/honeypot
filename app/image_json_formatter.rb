require 'json'

class ImageJsonFormatter
  attr_reader :image

  def initialize(image)
    @image = image
  end


  def to_json(options = {})
    {
      width: image.width,
      height: image.height,
      type: image.type,
      path: image.path,
      uri: image.uri
    }.to_json(options)
  end
end
