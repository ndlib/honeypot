require 'pathname'

class ImageSet
  class ImageNotFound < StandardError
  end

  attr_reader :relative_filepath

  def self.find(relative_filepath)
    image_set = new(relative_filepath)
    if !image_set.exists?
      raise ImageNotFound, "File not found: #{relative_filepath}"
    end
    image_set
  end

  def initialize(relative_filepath)
    @relative_filepath = relative_filepath
  end

  def original
    @original ||= build_image(original_filepath)
  end

  def original_filepath
    full_filepath(basename)
  end

  def pyramid_filepath
    derivative_filepath(:pyramid, pyramid_basename)
  end

  def thumbnail_filepath(style)
    derivative_filepath(style, thumbnail_basename)
  end

  def derivative_filepath(style, derivative_basename = basename)
    full_filepath(File.join(style.to_s, derivative_basename))
  end

  def derivatives
    @derivatives ||= build_derivatives
  end

  def exists?
    original.exists?
  end

  def basename
    relative_pathname.basename
  end

  def self.image_root
    @image_root ||= File.join(Rails.root, 'public', Rails.configuration.settings.image_path)
  end

  def self.full_to_relative_filepath(filepath)
    filepath.gsub(%r{^#{image_root}}, "")
  end

  private

    def build_image(filepath)
      Image.new(filepath)
    end

    def build_derivatives
      derivative_filepaths.collect{|filepath| build_derivative(filepath)}
    end

    def build_derivative(filepath)
      name = derivative_name(filepath)
      image = build_image(filepath)
      Derivative.new(name, image)
    end

    def basename_no_ext
      relative_pathname.basename('.*')
    end

    def pyramid_basename
      basename.sub_ext('.tif')
    end

    def thumbnail_basename
      basename.sub_ext('.jpg')
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

    def derivative_search_path
      full_filepath("*/#{basename_no_ext}.*")
    end

    def derivative_filepaths
      Dir[derivative_search_path]
    end

    def derivative_name(filepath)
      Pathname.new(filepath).dirname.basename.to_s
    end
end
