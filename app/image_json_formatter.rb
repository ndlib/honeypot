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
      path: image.uri_path,
      host: ApiApplication.settings.host,
    }.to_json(options)
  end
end
