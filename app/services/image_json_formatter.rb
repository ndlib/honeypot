require 'json'

class ImageJsonFormatter
  attr_reader :image

  def initialize(image)
    @image = image
  end

  def to_hash
    {
      width: image.width,
      height: image.height,
      path: image.uri_path,
      basename: image.uri_basename,
      host: Rails.configuration.settings.host,
    }
  end

  def to_json(options = {})
    to_hash.to_json(options)
  end
end
