require 'fastimage'

class Image

  attr_reader :path, :size

  def self.find(filepath)
    new(filepath)
  end

  def initialize(filepath)
    @path = filepath
  end

  def filename
    @filename ||= File.basename(path, '.*')
  end

  def original_realpath
    File.join(image_root, File.dirname(path), 'original', File.basename(path))
  end

  def uri
    "http://imagetile.library.nd.edu/#{path}"
  end

  def width
    size.first
  end

  def height
    size.last
  end

  def type
    @type ||= FastImage.type(original_realpath)
  end

  def size
    @size ||= FastImage.size(original_realpath)
  end

  def realpath
    File.join(image_root, File.dirname(path), filename + ".tif")
  end

  private

    def app_root
      File.expand_path('..', File.dirname(__FILE__))
    end

    def image_root
      File.join(app_root, ApiApplication.settings.image_path)
    end
end
