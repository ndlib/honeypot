require 'fastimage'

class Image

  attr_reader :path, :size

  def initialize(filepath)
    @path = filepath
  end

  def filename
    @filename ||= File.basename(realpath)
  end

  def converted_realpath
    File.join(app_root, File.dirname(path), 'converted', File.basename(filename, '.*') + ".tif")
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
    @type ||= FastImage.type(realpath)
  end

  def size
    @size ||= FastImage.size(realpath)
  end

  def realpath
    File.join(app_root, path)
  end

  private

    def app_root
      File.dirname(__FILE__) + '/../'
    end
end
