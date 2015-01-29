class ImageSetJsonDecorator < Draper::Decorator
  def id
    h.api_image_url(object.relative_filepath)
  end

  def image
    ImageJsonDecorator.new(object.original)
  end

  def name
    object.basename.to_s
  end

  def derivatives
    @derivatives ||= build_derivatives
  end

  private
    def build_derivatives
      object.derivatives.collect{|derivative| DerivativeJsonDecorator.new(derivative)}
    end
end
