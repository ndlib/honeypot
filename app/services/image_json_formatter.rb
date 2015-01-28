require 'json'

class ImageJsonFormatter
  attr_reader :image, :style

  def initialize(image, style)
    @image = image
    @style = style
  end

  def to_hash
    {
      id: style.to_s,
      width: image.width,
      height: image.height,
      type: image.type,
      src: src
    }
  end

  def src
    File.join(Rails.application.routes.url_helpers.root_url, Rails.configuration.settings.image_path, path)
  end

  def path
    ImageSet.full_to_relative_filepath(image.filepath)
  end

  def to_json(options = {})
    to_hash.to_json(options)
  end
end
