require 'fastimage'
require 'pathname'

class Image

  attr_reader :relative_filepath

  def self.find(relative_filepath)
    new(relative_filepath)
  end

  def initialize(relative_filepath)
    @relative_filepath = relative_filepath
  end

  def original_filepath
    full_filepath(basename)
  end

  def pyramid_filepath
    full_filepath(File.join("pyramid", pyramid_basename))
  end

  def derivative_filepath(style)
    full_filepath(File.join(style.to_s, basename))
  end

  def uri_path
    relative_path.to_s
  end

  def uri_basename
    basename.to_s
  end

  def width
    size.first
  end

  def height
    size.last
  end

  def type
    @type ||= FastImage.type(original_filepath)
  end

  def size
    @size ||= FastImage.size(original_filepath)
  end

  def self.image_root
    @image_root ||= File.join(Rails.root, Rails.configuration.settings.image_path)
  end

  private

    def basename
      relative_pathname.basename
    end

    def pyramid_basename
      basename.sub_ext('.tif')
    end

    def relative_pathname
      @relative_pathname ||= Pathname.new(relative_filepath)
    end

    def relative_path
      relative_pathname.dirname
    end

    def base_full_filepath
      @base_full_filepath ||= File.join(self.class.image_root, relative_path)
    end

    def full_filepath(path = nil)
      if path.present?
        File.join(base_full_filepath, path)
      else
        base_full_filepath
      end
    end
end
