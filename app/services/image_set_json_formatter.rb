require 'json'

class ImageSetJsonFormatter
  attr_reader :image_set

  def initialize(image_set)
    @image_set = image_set
  end

  def to_hash(options = {})
    {
      title: title,
      host: host,
      styles: styles_hash,
    }
  end

  def to_json(options = {})
    to_hash.to_json(options)
  end

  private

    def host
      Rails.configuration.settings.host
    end

    def title
      image_set.basename.to_s
    end

    def styles_hash
      {
        original: image_hash(image_set.original)
      }
    end

    def image_hash(image)
      ImageJsonFormatter.new(image).to_hash
    end
end
