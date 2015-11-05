# Rodakase [![Join the chat at https://gitter.im/solnic/rodakase](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/solnic/rodakase?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Rodakase is a lightweight web stack on top of Roda which gives you a foundation
for building robust web applications while decoupling your application code from
the framework.

There are a couple of core concepts in Rodakase which makes it stand out from the crowd:

* Container-based architecture where your application dependencies are accessible
  through a simple IoC container
* Promotes simple, side-effect-less, functional objects with a built-in auto-injection
  mechanism making it trivial to compose objects
* Roda routing is decoupled from core application logic and focuses purely on
  http-related concerns (status codes, session, cookies etc.)
* Rendering is decoupled too, roda routing simply gets response body from *your*
  objects
* Request processing and response construction in functional style as a series
  of simple "function" calls
* Extreme focus on proper code organization and reusability, functionality of your
  application should be easily accessible using clear APIs
* Uses ROM by default for persistence

Rodakase says **NO** to the following concepts:

* monkey-patching
* mutable global state
* hot-code reloading in dev mode leading to additional complexity, nasty gotchas
  and silly constraints with regards to code organization
* implicit dependency handling through magical const-loading mechanisms
* tight coupling between web application logic and core domain logic
* tight coupling between persistence logic and core domain logic

## Sample App

A sample rodakase-based web app is [right here](https://github.com/solnic/rodakase-blog).

## Status

This project hasn't been released yet. It's under heavy development.

## Tools

Rodakase is based on a bunch of awesome libraries:

* roda
* roda-flow
* dry-container
* dry-auto_inject
* tilt
* call_sheet

## The Book

Rodakase will be described in ["Web Development with ROM and Roda"](https://leanpub.com/web-development-with-rom-and-roda) book
that I'm working on. If you're interested in the project and/or the book, feel free
to join [Rodakase gitter channel](https://gitter.im/solnic/rodakase).

## LICENSE

See `LICENSE.txt` file.

## Installation

Add this line to your application's Gemfile:

```
gem 'rodakase'
```

And then execute:

$ bundle

Or install it yourself as:

```
$ gem install rodakase
```

## Development

After checking out the repo, run bin/setup to install dependencies. Then, run rake spec to run the tests. You can also run bin/console for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run bundle exec rake install. To release a new version, update the version number in version.rb, and then run bundle exec rake release, which will create a git tag for the version, push git commits and tags, and push the .gem file to rubygems.org.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/solnic/rodakase.
