# Omniauth::Stripe

[![Travis-CI](https://travis-ci.org/fnando/omniauth-stripe.svg)](https://travis-ci.org/fnando/omniauth-stripe)
[![CodeClimate](https://codeclimate.com/github/fnando/omniauth-stripe.svg)](https://codeclimate.com/github/fnando/omniauth-stripe)
[![Test Coverage](https://codeclimate.com/github/fnando/omniauth-stripe/badges/coverage.svg)](https://codeclimate.com/github/fnando/omniauth-stripe/coverage)
[![Gem](https://img.shields.io/gem/v/omniauth-stripe.svg)](https://rubygems.org/gems/omniauth-stripe)
[![Gem](https://img.shields.io/gem/dt/omniauth-stripe.svg)](https://rubygems.org/gems/omniauth-stripe)

[Stripe](http://stripe.com)'s OAuth Strategy for OmniAuth.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-stripe'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-stripe

## Usage

`OmniAuth::Strategies::Stripe` is simply a Rack middleware. Read the OmniAuth docs for detailed instructions: <https://github.com/intridea/omniauth>.

First, configure your Connect account at >https://dashboard.stripe.com/account/applications/settings>. Your callback URL must be something like `https://example.com/auth/stripe/callback`. For development you can use `http://127.0.0.1:3000/auth/stripe/callback`.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`. This example assumes you're exporting your credentials as environment variables.

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :stripe, 
            ENV['STRIPE_CLIENT_ID'], 
            ENV['STRIPE_CLIENT_SECRET']
end
```

Now visit `/auth/stripe` to start authentication against Stripe.

## Contributing

1. Fork [omniauth-stripe](https://github.com/fnando/omniauth-stripe/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
