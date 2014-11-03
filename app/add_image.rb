require File.dirname(__FILE__) + '/copy_image'
require File.dirname(__FILE__) + '/convert_image'
require File.dirname(__FILE__) + '/image'

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

  def image
    @image ||= Image.new(File.join(params[:namespace], params[:image][:filename]))
  end

  private

    def copy_image
      CopyImage.call(params[:image], image)
    end

    def convert_image
      ConvertImage.call(image)
    end
end
