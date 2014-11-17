require 'fastimage'
require 'pathname'

class Image

  attr_reader :namespace, :filename

  def self.find(filepath)
    new(filepath)
  end

  def initialize(filepath)
    set_namespace_and_filename(filepath)
  end

  def original_realpath
    @original_realpath ||= find_original_filepath
  end

  def uri_path
    "#{namespace}/#{filename}"
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
    File.join(basepath, filename + ".tif")
  end

  def self.app_root
    @app_root ||= File.expand_path('..', File.dirname(__FILE__))
  end

  def self.image_root
    @image_root ||= File.join(app_root, ApiApplication.settings.image_path)
  end

  private

    def basepath
      @basepath ||= File.join(self.class.image_root, namespace)
    end

    def original_basepath
      File.join(basepath, "original")
    end

    def find_original_filepath
      Dir[original_searchpath].first || original_fullpath_fallback
    end

    def original_fullpath_fallback
      File.join(original_basepath, "#{filename}.jpg")
    end

    def original_searchpath
      File.join(original_basepath, "#{filename}.*")
    end

    def set_namespace_and_filename(filepath)
      pathname = Pathname.new(filepath)
      @namespace = pathname.dirname.to_s
      @filename = pathname.basename().to_s
    end
end
