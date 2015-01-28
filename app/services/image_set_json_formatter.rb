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
        image_set.derivatives.each do |style, image|
          array << image_hash(image, style)
        end
      end
    end

    def image_hash(image, style)
      ImageJsonFormatter.new(image, style).to_hash
    end
end
