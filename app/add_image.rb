
class AddImage

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
    @image ||= find_or_create_image
  end

  private

    def find_or_create_image

    end

    def copy_image

    end

    def convert_image

    end


end
