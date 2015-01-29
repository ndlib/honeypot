class Derivative
  attr_reader :type, :image

  def initialize(type, image)
    @type = type
    @image = image
  end
end
