class AddImage
  attr_reader :image, :params

  def self.call(params)
    self.new(params).upload!
  end

  def initialize(params)
    @params = params
  end

  def upload!
    copy_image
    convert_image

    image
  end

  def basefilename
    File.basename(uploaded_image.original_filename, '.*')
  end

  def filepath
    File.join(params[:namespace], basefilename)
  end

  def image
    @image ||= Image.build_from_path(filepath)
  end

  private

    def uploaded_image
      params[:image]
    end

    def copy_image
      CopyImage.call(uploaded_image, image)
    end

    def convert_image
      ConvertImage.call(image)
    end
end
