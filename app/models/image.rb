require 'fastimage'
require 'pathname'

class Image
  class ImageNotFound < StandardError
  end

  attr_reader :filepath

  def self.find(filepath)
    image = new(filepath)
    if !image.exists?
      raise ImageNotFound, "File not found: #{filepath}"
    end
    image
  end

  def initialize(filepath)
    puts filepath.inspect
    @filepath = filepath
  end

  def width
    size_array[0]
  end

  def height
    size_array[1]
  end

  def exists?
    File.exists?(filepath)
  end

  def type
    @type ||= FastImage.type(filepath)
  end

  def size
    @size ||= FastImage.size(filepath)
  end

  def relative_filepath
    ImageSet.full_to_relative_filepath(filepath)
  end

  def updated_at
    File.mtime(filepath)
  end

  private

    def size_array
      size || []
    end
end
