require 'fileutils'

class CopyImage
  attr_reader :image, :uploaded_file

  def self.call(uploaded_file, image)
    new(uploaded_file, image).copy
  end

  def initialize(uploaded_file, image)
    @image = image
    @uploaded_file = uploaded_file
  end

  def copy
    verify_directory
    copy_file

    save_path
  end

  def save_path
    image.original_realpath
  end

  private

    def verify_directory
      dirname = File.dirname(save_path)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
    end

    def copy_file
      File.open(save_path, "wb") { |f| f.write(uploaded_file[:tempfile].read) }
    end
end
