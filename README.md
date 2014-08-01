# MotionOcean

[![Gem Version](https://badge.fury.io/rb/motion_ocean.svg)](http://badge.fury.io/rb/motion_ocean)

RubyMotion library for [version 2 of DigitalOcean's API](https://developers.digitalocean.com/v2/)

**Please note that version 2 of DigitalOcean's API is in beta, and is still
being developed. Everything is subject to change.**

### Installation

Add this line to your application's Gemfile:

``` ruby
gem 'motion_ocean'
```

And then execute:
``` sh
$ bundle
```

Or install it yourself as:

``` sh
$ gem install motion_ocean
```

### Initialization

``` ruby
client = MotionOcean::Client.new(access_token: 'token')
```

*or*

``` ruby
client = MotionOcean::Client.new do |config|
  config.access_token = 'token'
end
```

### Usage

The API client is based on NSURLSession and every request is executed asynchronously. Every MotionOcean method call therefore requires a block, which yields a `MotionOcean::API::Response`.

MotionOcean pretty much implements the DO API 1:1, so please check [their documentation](https://developers.digitalocean.com/v2/) for the available functions and options.

### The response object

#### success?

You can use `success?` to check if a successful HTTP status code was returned:

``` ruby
client.droplet.create(options) do |result|
  result.success? # => true
end
```

#### data

The response data is assigned to the `data`-property of the response object. This is a `Hash` which 
corresponds with the returned JSON by DigitalOcean.

``` ruby
client.droplet.create(options) do |result|
  result.data # => Hash with the JSON response
end
```


#### response

MotionOcean uses NSURLSession. You can use `response` to get to the original response
object:

``` ruby
client.droplet.create(options) do |result|
  result.response # => NSHTTPURLResponse
end
```
#### error

When there is an error you can check this for the specific error. If you think it is a bug in MotionOcean, please open an issue or even better: submit a Pull Request with the fix!

## Aknowledgements

This library is an adaptation for RubyMotion of [barge](https://github.com/boats/barge) by [Ørjan Blom](https://github.com/blom). 

The brilliant [MotionInMotion](https://motioninmotion.tv) screencasts helped me with implementing the API client using NSURLSession (specifically [episode #33](https://motioninmotion.tv/screencasts/33)) and iOS development using RubyMotion in general.

## Contributing

1. Fork it ( https://github.com/datarift/motion_ocean/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
