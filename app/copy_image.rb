class CopyImage
  IMAGE_BASE_PATH = '/system/saved_files/'
  attr_reader :image, :uploaded_file

  def self.call(uploaded_file, image)
    new(uploaded_file, image).copy
  end

  def initialize(uploaded_file, image)
    @image = image
    @uploaded_file = uploaded_file
  end

  def copy
    File.open(save_path, "wb") { |f| f.write(uploaded_file[:tempfile].read) }
    save_path
  end

  def save_path
    image.realpath
  end

end
