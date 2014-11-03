require 'fastimage'

class Image
  IMAGE_BASE_PATH = '/system/saved_files/'

  attr_reader :path, :size

  def initialize(filepath)
    @path = filepath
  end

  def filename
    @filename ||= File.basename(realpath, '.*')
  end

  def converted_realpath
    File.join(app_root, IMAGE_BASE_PATH, File.dirname(path), 'converted', filename + ".tif")
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
    File.join(app_root, IMAGE_BASE_PATH, path)
  end

  def to_json(options = {})
    {
      width: width,
      height: height,
      type: type,
      path: path,
      uri: uri
    }.to_json
  end

  private

    def app_root
      File.dirname(__FILE__) + '/../'
    end
end
