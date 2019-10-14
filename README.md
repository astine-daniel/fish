# Fish

## Prerequisites

There are some prerequisites needed to build the app.

They are:

- Ruby
- Bundler
- Cocoapods

### Ruby

There are some environment dependencies that need Ruby to run. In order to use
the same Ruby version it is recommended to install
[rbenv](https://github.com/rbenv/rbenv) or another Ruby version manager.

```sh
brew install rbenv
```

Install the Ruby version used on the project:

```sh
rbenv install `cat .ruby-version`
```

### Using [Bundler](https://bundler.io/)

Provides a consistent environment when using Ruby dependencies.

```sh
gem install bundler
```

### Using [CocoaPods](https://cocoapods.org/)

Dependency manager for Swift and Objective-C Cocoa projects.

```sh
bundle install
```

## App dependencies

The app use some third party dependencies and some development dependencies.

To install:

```sh
bundle exec pod install
```

### [Kingfisher](https://github.com/onevcat/Kingfisher)

Kingfisher is a powerful, pure-Swift library for downloading and caching images
from the web.

It is used to cache the offer image.

### [SwiftGen](https://github.com/SwiftGen/SwiftGen)

The Swift code generator for your assets, storyboards, Localizable.strings, ….

SwiftGen is a tool to auto-generate Swift code for resources of your projects,
to make them type-safe to use.

### [SwiftLint](https://github.com/realm/SwiftLint)

A tool to enforce Swift style and conventions.
