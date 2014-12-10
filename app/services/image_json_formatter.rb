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
      type: image.type,
      path: path,
    }
  end

  def path
    ImageSet.full_to_relative_filepath(image.filepath)
  end

  def to_json(options = {})
    to_hash.to_json(options)
  end
end
