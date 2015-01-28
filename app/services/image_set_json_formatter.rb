require 'json'

class ImageSetJsonFormatter
  attr_reader :image_set

  def initialize(image_set)
    @image_set = image_set
  end

  def to_hash(options = {})
    {
      title: title,
      href: href,
      links: links
    }
  end

  def links
    {
      styles: styles,
      dzi: dzi
    }
  end

  def to_json(options = {})
    to_hash.to_json(options)
  end

  private

    def href
      Rails.application.routes.url_helpers.api_image_url(image_set.relative_filepath)
    end

    def title
      image_set.basename.to_s
    end

    def styles
      [].tap do |array|
        array << image_hash(image_set.original, :original)
        derivatives_without_pyramid.each do |style, image|
          array << image_hash(image, style)
        end
      end
    end

    def dzi
      dzi_hash(pyramid_derivative)
    end

    def derivatives_without_pyramid
      image_set.derivatives.reject{|key, value| key.to_sym == :pyramid}
    end

    def pyramid_derivative
      image_set.derivatives[:pyramid]
    end

    def image_hash(image, style)
      ImageJsonFormatter.new(image, style).to_hash
    end

    def dzi_hash(image)
      if image
        ImageDziJsonFormatter.new(image, :dzi).to_hash
      else
        nil
      end
    end
end
