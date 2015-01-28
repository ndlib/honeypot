require 'json'

class ImageDziJsonFormatter < ImageJsonFormatter
  def type
    :dzi
  end

  def path
    "#{image.relative_filepath}.dzi"
  end
end
