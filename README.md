[gem]: https://rubygems.org/gems/dry-web
[travis]: https://travis-ci.org/dry-rb/dry-web
[codeclimate]: https://codeclimate.com/github/dry-rb/dry-web
[inchpages]: http://inch-ci.org/github/dry-rb/dry-web/

# dry-web [![Join the chat at https://gitter.im/dry-rb/chat](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dry-rb/chat?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Gem Version](https://badge.fury.io/rb/dry-web.svg)][gem]
[![Build Status](https://travis-ci.org/dry-rb/dry-web.svg?branch=master)][travis]
[![Code Climate](https://codeclimate.com/github/dry-rb/dry-web/badges/gpa.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/dry-rb/dry-web/badges/coverage.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/dry-rb/dry-web.svg?branch=master&style=flat)][inchpages]

## Tools

dry-web is composed from the following libraries:

* [dry-component](https://github.com/dry-rb/dry-component)
* [dry-transaction](https://github.com/dry-rb/dry-transaction)

## LICENSE

See `LICENSE.txt` file.

## Development

To run the specs make sure the dummy app uses proper db configuration `spec/dummy/config/application.yml`.
Also you need to run the migrations, do following:

```
  $ cd spec/dummy
  $ bundle install
  $ rake db:migrate
```

After that you can run the specs from dry-web root:

```
  $ bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dry-rb/dry-web.
