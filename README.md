# MotionOcean

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

Since MotionOcean is based on [AFMotion][afmotion], requests are being made asynchronous. Every MotionOcean method call therefore requires a block, which yields the data (or nil if the request failed).

MotionOcean pretty much implements the DO API 1:1, so please check [their documentation](https://developers.digitalocean.com/v2/) for the available functions and options.

### success?

You can use `success?` to check if a successful HTTP status code was returned:

``` ruby
client.droplet.create(options) do |result|
  result.success? # => true
end
```

### response

MotionOcean uses [AFMotion][afmotion]. You can use `response` to get to the response
object:

``` ruby
client.droplet.create(options) do |result|
  result.response # => AFMotion::HTTPResult
end
```
[afmotion]: https://github.com/usepropellor/afmotion

## Aknowledgements

This library is an adaptation for RubyMotion of [barge](https://github.com/boats/barge) by [Ørjan Blom](https://github.com/blom). 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/motion_ocean/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
