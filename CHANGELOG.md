# v0.1.0 / 2016-04-21

### Changed

– Renamed from rodakase to dry-web
– Dependency management features were extracted into [dry-component](https://github.com/dry-rb/dry-component)
– `Rodakase::View` was extracted into the [dry-view](https://github.com/dry-rb/dry-view) gem

# v0.0.1 / 2015-11-13

Awesome, first release on Friday 13th. Let's be optimistic. This release ships with:

- `Rodakase::Container` API for dependency management and component loading
- `Rodakase::Application` customized `Roda::Application` API for web part
- `Rodakase::Transaction` for composing processing pipelines
- `Rodakase::View` an experimental, helper-less, template-as-data view layer
