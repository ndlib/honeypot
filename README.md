# Honeypot - Image processor and server

[![Build Status](https://travis-ci.org/ndlib/honeypot.svg?branch=master)](https://travis-ci.org/ndlib/honeypot)
[![Coverage Status](https://img.shields.io/coveralls/ndlib/honeypot.svg)](https://coveralls.io/r/ndlib/honeypot?branch=master)
[![Code Climate](https://codeclimate.com/github/ndlib/honeypot/badges/gpa.svg)](https://codeclimate.com/github/ndlib/honeypot)

To run in development

1. `bundle`
2. `bundle exec guard`

## Usage

### To send an image to server.

post multipart data to /api/images

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

connection.post('/api/images', { application_id: 'honeycomb', group_id: 1, item_id: 2, image: Faraday::UploadIO.new(path_to_image, icontent_type) })
```

#### Data received back

JSON
```JSON
{
  "image":{
    "title":"1200x1600.jpg",
    "href":"http://localhost:3019/api/images/test/000/001/000/002/1200x1600.jpg",
    "links":{
      "styles":[
        {
          "id":"original",
          "width":1200,
          "height":1600,
          "type":"jpeg",
          "src":"http://localhost:3019/images/test/000/001/000/002/1200x1600.jpg"
        },
        {
          "id":"medium",
          "width":600,
          "height":800,
          "type":"jpeg",
          "src":"http://localhost:3019/images/test/000/001/000/002/medium/1200x1600.jpg"
        },
        {
          "id":"small",
          "width":150,
          "height":200,
          "type":"jpeg",
          "src":"http://localhost:3019/images/test/000/001/000/002/small/1200x1600.jpg"
        }
      ],
      "dzi":{
        "id":"dzi",
        "width":1200,
        "height":1600,
        "type":"dzi",
        "src":"http://localhost:3019/images/test/000/001/000/002/pyramid/1200x1600.tif.dzi"
      }
    }
  }
}
```

### to look up an image
Retrieves them same JSON as above.

GET http://localhost:3019/api/images/test/000/001/000/002/1200x1600.jpg
