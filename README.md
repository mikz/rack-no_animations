# Rack::NoAnimations

Stops CSS/jQuery animations by injecting style overrides and using `jQuery.fx.off`.


## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'rack-no_animations'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-no_animations

## Usage

in `config/environments/test.rb` add the middleware to rails like:

```ruby
  config.middleware.use Rack::NoAnimations
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mikz/rack-no_animations.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

