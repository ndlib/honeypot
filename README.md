# HONEYPOT !!!

to run in development

1. `bundle`
2. `rerun 'rackup -p 4567'` (rerun automatically reloads the application when changes are made)

To allow external connections in development mode:

`rerun 'rackup -p 4567 -o 0.0.0.0'`


## Usage

### To send an image to server.

post multipart data to /images

with the params

namespace:  is a distinguishing variable to ensure that you are not overwritting other content.  I recomend starting with the name of the application posting and then anything else you need to ensure data integrity.  i.e. "application_name/id/otherid"

image: "the image data "

Faraday Example:
```ruby
connection ||= Faraday.new("api_url") do |f|
  f.request :multipart
  f.request :url_encoded
  f.adapter :net_http
end

connection.post('/add_image', { namespace: 'namespace', image: Faraday::UploadIO.new(path_to_image, icontent_type) })
```

#### Data received back

JSON
```JSON
{
  "image":{
    "width":1200,
    "height":1600,
    "path":"namespace/IMG_0108",
    "host":"imagetile.library.nd.edu"
  }
}
```

### to look up an image

GET https://imagetile.library.nd.edu/images/namespace/to/image


retrieves
JSON
```JSON
{
  "image":{
    "width":1200,
    "height":1600,
    "path":"namespace/to/image",
    "host":"imagetile.library.nd.edu"
  }
}
```
