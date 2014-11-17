# HONEYPOT !!!

to run in development

1. bundle
2. rerun 'rackup -p 4567'


## Usage

### To send an image to server.

post multipart data to /images

with the params

namespace:  is a distinguishing variable to ensure that you are not overwritting other content.  I recomend starting with the name of the application posting and then anything else you need to ensure data integrity.  i.e. "application_name/id/otherid"

image: "the image data "

Faraday Example:
connection ||= Faraday.new("api_url") do |f|
        f.request :multipart
        f.request :url_encoded
        f.adapter :net_http
      end

connection.post('/add_image', { namespace: 'namespace', image: Faraday::UploadIO.new(path_to_image, icontent_type) })

#### Data received back

JSON
{
  "image":{
    "width":1200,
    "height":1600,
    "type":"jpeg",
    "path":"namspace/IMG_0108.jpg",
    "uri":"http://imagetile.library.nd.edu/namspace/IMG_0108.jpg"
  }
}


### to look up an image

get /images/namespace/to/file.extension


retreives
JSON
{
  "image":{
    "width":1200,
    "height":1600,
    "type":"jpeg",
    "path":"namspace/IMG_0108.jpg",
    "uri":"http://imagetile.library.nd.edu/namspace/IMG_0108.jpg"
  }
}
