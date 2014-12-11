class CopyImage
  attr_reader :image_set, :uploaded_file

  def self.call(uploaded_file, image_set)
    new(uploaded_file, image_set).copy
  end

  def initialize(uploaded_file, image_set)
    @image_set = image_set
    @uploaded_file = uploaded_file
  end

  def copy
    verify_directory
    copy_file

    save_path
  end

  def save_path
    image_set.original_filepath
  end

  private

    def verify_directory
      dirname = File.dirname(save_path)
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
    end

    def copy_file
      File.open(save_path, "wb") { |f| f.write(uploaded_file.read) }
    end
end
