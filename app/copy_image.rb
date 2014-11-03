class CopyImage
  IMAGE_BASE_PATH = '/system/saved_files/'
  attr_reader :base_path, :uploaded_file

  def self.call(uploaded_file, base_path)
    new(uploaded_file, base_path).copy
  end

  def initialize(uploaded_file, base_path)
    @base_path = base_path
    @uploaded_file = uploaded_file
  end

  def copy
    File.open(save_path, "wb") { |f| f.write(uploaded_file[:tempfile].read) }
    file_path
  end

  def save_path
    File.join(app_root, file_path)
  end

  private

    def file_path
      File.join(IMAGE_BASE_PATH, base_path, uploaded_file[:filename])
    end


    def app_root
      File.dirname(__FILE__) + '/../'
    end
end
