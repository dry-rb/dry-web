[gem]: https://rubygems.org/gems/dry-web
[travis]: https://travis-ci.org/dry-rb/dry-web
[gemnasium]: https://gemnasium.com/dry-rb/dry-web
[codeclimate]: https://codeclimate.com/github/dry-rb/dry-web
[inchpages]: http://inch-ci.org/github/dry-rb/dry-web/

# dry-web [![Join the chat at https://gitter.im/dry-rb/dry-web](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/dry-rb/dry-web?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Gem Version](https://badge.fury.io/rb/dry-web.svg)][gem]
[![Build Status](https://travis-ci.org/dry-rb/dry-web.svg?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/dry-rb/dry-web.svg)][gemnasium]
[![Code Climate](https://codeclimate.com/github/dry-rb/dry-web/badges/gpa.svg)][codeclimate]
[![Test Coverage](https://codeclimate.com/github/dry-rb/dry-web/badges/coverage.svg)][codeclimate]
[![Inline docs](http://inch-ci.org/github/dry-rb/dry-web.svg?branch=master&style=flat)][inchpages]

dry-web is a lightweight web stack on top of Roda which gives you a foundation
for building robust web applications while decoupling your application code from
the framework.

There are a couple of core concepts in dry-web which makes it stand out from the crowd:

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

dry-web says **NO** to the following concepts:

* monkey-patching
* mutable global state
* hot-code reloading in dev mode leading to additional complexity, nasty gotchas
  and silly constraints with regards to code organization
* implicit dependency handling through magical const-loading mechanisms
* tight coupling between web application logic and core domain logic
* tight coupling between persistence logic and core domain logic

## Sample App

A sample dry-web-based web app is [right here](https://github.com/dry-rb/dry-web-blog).

## Status

This project hasn't been released yet. It's under heavy development.

## Tools

dry-web is based on a bunch of awesome libraries:

* roda
* roda-flow
* dry-container
* dry-auto_inject
* tilt
* transflow

## The Book

dry-web will be described in ["Web Development with ROM and Roda"](https://leanpub.com/web-development-with-rom-and-roda) book
that I'm working on. If you're interested in the project and/or the book, feel free
to join [dry-web gitter channel](https://gitter.im/dry-rb/dry-web).

## LICENSE

See `LICENSE.txt` file.

## Installation

Add this line to your application's Gemfile:

```
gem 'dry-web'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install dry-web
```

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
