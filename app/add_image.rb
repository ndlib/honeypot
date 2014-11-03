require File.dirname(__FILE__) + '/copy_image'
require File.dirname(__FILE__) + '/convert_image'

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

  private

    def copy_image
      filepath = CopyImage.call(params[:image], params[:namespace])
      @image = Image.new(filepath)
    end

    def convert_image
      ConvertImage.call(image)
    end
end
