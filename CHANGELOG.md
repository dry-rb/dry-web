# Unreleased

### Added

– `Rodakase::View::Layout` supports multiple view template formats. Configure format/engine pairs (e.g. `{html: :slim, text: :erb}`) on the `formats` setting. The first format becomes the default. Request specific formats when calling the view, e.g. `my_view.call(format: :text)`.

# v0.0.1 2015-11-13

Awesome, first release on Friday 13th. Let's be optimistic. This release ships with:

- `Rodakase::Container` API for dependency management and component loading
- `Rodakase::Application` customized `Roda::Application` API for web part
- `Rodakase::Transaction` for composing processing pipelines
- `Rodakase::View` an experimental, helper-less, template-as-data view layer
