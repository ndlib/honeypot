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
    File.basename(params[:image][:filename], '.*')
  end

  def filepath
    File.join(params[:namespace], basefilename)
  end

  def image
    @image ||= Image.new(filepath)
  end

  private

    def copy_image
      CopyImage.call(params[:image], image)
    end

    def convert_image
      ConvertImage.call(image)
    end
end
