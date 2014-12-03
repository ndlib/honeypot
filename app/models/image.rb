require 'fastimage'
require 'pathname'
require 'active_model'

class Image
  include ActiveModel::Model
  include Paperclip::Glue

  define_model_callbacks :save, only: [:after]
  define_model_callbacks :commit, only: [:after]
  define_model_callbacks :destroy, only: [:before, :after]

  attr_accessor :namespace, :filename
  attr_accessor :attachment_file_name
  has_attached_file :attachment,
    styles: { small: ["x200", :jpg], medium: ["x800", :jpg], square: ["600x600#", :jpg] },
    path: ":rails_root/public/images/:namespace/:basename/:style.:extension",
    url: ":rails_root/public/images/:namespace/:basename/:style.:extension"

  def self.find(filepath)
    build_from_path(filepath)
  end

  def self.build_from_path(filepath)
    attributes = get_namespace_and_filename(filepath)
    new(attributes)
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

  def self.image_root
    @image_root ||= File.join(Rails.root, Rails.configuration.settings.image_path)
  end

  def save
    run_callbacks :save do
    end
  end

  def destroy
    run_callbacks :destroy do
    end
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

    def self.get_namespace_and_filename(filepath)
      pathname = Pathname.new(filepath)
      {
        namespace: pathname.dirname.to_s,
        filename: pathname.basename.to_s
      }
    end
end
