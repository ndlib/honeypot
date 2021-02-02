# Honeypot - Image processor and server

[![Build Status](https://travis-ci.org/ndlib/honeypot.svg?branch=master)](https://travis-ci.org/ndlib/honeypot)
[![Coverage Status](https://img.shields.io/coveralls/ndlib/honeypot.svg)](https://coveralls.io/r/ndlib/honeypot?branch=master)
[![Code Climate](https://codeclimate.com/github/ndlib/honeypot/badges/gpa.svg)](https://codeclimate.com/github/ndlib/honeypot)

To run in development

1. `bundle`
2. `bundle exec guard`

## Usage

### To send an image to server.

post multipart data to /api/v1/images

with the params

* application_id: String name of the application posting to the service, used for namespacing. e.g. "honeycomb"
* group_id: Integer value identifying a group or collection the item belongs to, used for namespacing.
* item_id: Integer value of the item the image belongs to.
* image: Image upload file

Faraday Example:
```ruby
connection ||= Faraday.new("http://localhost:3019") do |f|
  f.request :multipart
  f.request :url_encoded
  f.adapter :net_http
end

connection.post('/api/v1/images', { application_id: 'honeycomb', group_id: 1, item_id: 2, image: Faraday::UploadIO.new(path_to_image, icontent_type) })
```

Curl Example:
```sh
curl \
  -F "application_id=honeycomb" \
  -F "group_id=1" \
  -F "item_id=2" \
  -F "image=@/path/to/image" \
  http://localhost:3019/api/v1/images
```

#### Data received back

JSON
```JSON
{
  "@context":"http://schema.org",
  "@type":"ImageObject",
  "@id":"http://localhost:3019/api/v1/images/test/000/001/000/002/1200x1600.jpg",
  "width":"1200 px",
  "height":"1600 px",
  "encodingFormat":"jpeg",
  "contentUrl":"http://localhost:3019/images/test/000/001/000/002/1200x1600.jpg",
  "name":"1200x1600.jpg",
  "thumbnail/medium":{
    "@type":"ImageObject",
    "width":"600 px",
    "height":"800 px",
    "encodingFormat":"jpeg",
    "contentUrl":"http://localhost:3019/images/test/000/001/000/002/medium/1200x1600.jpg"
  },
  "thumbnail/dzi":{
    "@type":"ImageObject",
    "width":"1200 px",
    "height":"1600 px",
    "encodingFormat":"dzi",
    "contentUrl":"http://localhost:3019/images/test/000/001/000/002/pyramid/1200x1600.tif.dzi"
  },
  "thumbnail/small":{
    "@type":"ImageObject",
    "width":"150 px",
    "height":"200 px",
    "encodingFormat":"jpeg",
    "contentUrl":"http://localhost:3019/images/test/000/001/000/002/small/1200x1600.jpg"
  }
}
```

### to look up an image
Retrieves them same JSON as above.

GET http://localhost:3019/api/v1/images/test/000/001/000/002/1200x1600.jpg
