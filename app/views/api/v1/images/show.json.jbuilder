json.set! '@context', 'http://schema.org'
json.set! '@type', 'ImageObject'
json.set! '@id', @image_set.id
json.partial! 'image', image: @image_set.image
json.name @image_set.name
@image_set.derivatives.each do |derivative|
  json.set! "thumbnail/#{derivative.thumbnail_type}" do
    json.set! '@type', 'ImageObject'
    json.partial! 'image', image: derivative
  end
end
