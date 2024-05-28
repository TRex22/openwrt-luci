# OpenwrtLuci
API Client to communicate with OpenWRT via the Luci interface

This is an unofficial project and still a work in progress (WIP) ... more to come soon.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openwrt-luci'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openwrt-luci

## Usage

```ruby
  require 'openwrt-luci'
  client = OpenwrtLuci::Client.new(base_path: "http://192.168.0.1", port: 80, username: 'your username', password: 'your password', verify_ssl: false)
  client.backup # Return backup file as a stream

  # verify_ssl is used if the controller has SSL configured
```

### Endpoints
  - Login
  - Backup

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Tests
To run tests execute:

    $ rake test

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trex22/openwrt-luci. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the openwrt-luci: project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/trex22/openwrt-luci/blob/master/CODE_OF_CONDUCT.md).
