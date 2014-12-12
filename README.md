# Honeypot - Image processor and server

[![Build Status](https://travis-ci.org/ndlib/honeypot.svg?branch=master)](https://travis-ci.org/ndlib/honeypot)
[![Coverage Status](https://img.shields.io/coveralls/ndlib/honeypot.svg)](https://coveralls.io/r/ndlib/honeypot?branch=master)

To run in development

1. `bundle`
2. `bundle exec guard`

## Usage

### To send an image to server.

post multipart data to /api/images

with the params

namespace:  is a distinguishing variable to ensure that you are not overwritting other content.  I recomend starting with the name of the application posting and then anything else you need to ensure data integrity.  i.e. "application_name/id/otherid"

image: "the image data "

Faraday Example:
```ruby
connection ||= Faraday.new("http://localhost:3019") do |f|
  f.request :multipart
  f.request :url_encoded
  f.adapter :net_http
end

connection.post('/api/images', { namespace: 'namespace', image: Faraday::UploadIO.new(path_to_image, icontent_type) })
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

GET http://localhost:3019/api/images/namespace/to/image


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
