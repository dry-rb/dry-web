## 0.8.0 2018-01-02


### Changed

- Updated to `dry-system ~> 0.9` (solnic)

[Compare v0.7.1...v0.8.0](https://github.com/dry-rb/dry-web/compare/v0.7.1...v0.8.0)

## 0.7.1 2017-07-25


### Changed

- Default log level for `:test` env is set to `Logger::DEBUG` (solnic)

[Compare v0.7.0...v0.7.1](https://github.com/dry-rb/dry-web/compare/v0.7.0...v0.7.1)

## 0.7.0 2017-06-16


### Changed

- [BREAKING] `Dry::Web::Settings` now loads settings from local `.env` and `.env.<environment>` files (GustavoCaso)
- [BREAKING] Removed `Dry::Web::Umbrella` with special handling of settings. Settings should for now be provided as a bootable component within your applications (dry-web-roda will be updated to generate such) (timriley)

[Compare v0.6.0...v0.7.0](https://github.com/dry-rb/dry-web/compare/v0.6.0...v0.7.0)

## 0.6.0 2017-02-02


### Added

- Support for [dry-monitor](https://github.com/dry-rb/dry-monitor) with notifications and rack logging (solnic)


[Compare v0.5.0...v0.6.0](https://github.com/dry-rb/dry-web/compare/v0.5.0...v0.6.0)

## 0.5.0 2016-08-15

Update to work with dry-system


[Compare v0.4.1...v0.5.0](https://github.com/dry-rb/dry-web/compare/v0.4.1...v0.5.0)

## 0.4.1 2016-07-26


### Changed

- Set a higher minimum Ruby version (>= 2.1.0) to match dry-auto_inject (timriley)

[Compare v0.4.0...v0.4.1](https://github.com/dry-rb/dry-web/compare/v0.4.0...v0.4.1)

## 0.4.0 2016-07-26


### Changed

- Require dry-component 0.4.1 for latest `Dry::Component::Container#injector` features and API (timriley)

[Compare v0.3.1...v0.4.0](https://github.com/dry-rb/dry-web/compare/v0.3.1...v0.4.0)

## 0.3.1 2016-06-22


### Changed

- Added a necessary version spec for the dry-component dependency (timriley)

[Compare v0.3.0...v0.3.1](https://github.com/dry-rb/dry-web/compare/v0.3.0...v0.3.1)

## 0.3.0 2016-06-22


### Added

- Added an `Umbrella` subclass of `Dry::Web::Container`, intended to be a single, top-level wrapper around multiple sub-apps in a dry-web project (timriley)
- Added `Dry::Web::Settings`, designed to work as an app's single, top-level settings object (timriley)
- Added `env` config to `Dry::Web::Container`, moved across from dry-component (timriley)

### Changed

- Renamed `Dry::Web::Cli` to `Dry::Web::Console`, to make room for a real CLI in the future, starting with dry-web-roda (timriley)

[Compare v0.2.0...v0.3.0](https://github.com/dry-rb/dry-web/compare/v0.2.0...v0.3.0)

## 0.2.0 2016-06-12


### Changed

- Extracted Roda support into [dry-web-roda](https://github.com/dry-rb/dry-web-roda) (timriley)
- Removed `Dry::Web::Transaction::Composer`, which was offering no value above direct calls to `Dry.Transaction` (timriley)
- Basic skeleton example removed, since skeletons/app generators will soon be provided elsewhere (timriley)

[Compare v0.1.0...v0.2.0](https://github.com/dry-rb/dry-web/compare/v0.1.0...v0.2.0)

## 0.1.0 2016-04-21


### Changed

- – Renamed from rodakase to dry-web
- – Dependency management features were extracted into [dry-component](https://github.com/dry-rb/dry-component)
- – `Rodakase::View` was extracted into the [dry-view](https://github.com/dry-rb/dry-view) gem

[Compare v0.0.1...v0.1.0](https://github.com/dry-rb/dry-web/compare/v0.0.1...v0.1.0)

## 0.0.1 2015-11-13

Awesome, first release on Friday 13th. Let's be optimistic. This release ships with:
