# Bootsy Changelog

## 2.4.0

* Full compatibility with Rails 5 (#244 thanks @dnswus).
* jQuery 3.0 support (#259 - thanks @adeelejaz).
* Update CarrierWave to 1.0 (#256 - thanks @adeelejaz).

## 2.3.1

* Bootsy now supports Turbolinks 5 and up.

## 2.3.0

* Bootsy no longer depends on Remotipart.
* Fix bug where modal is rendered with the app layout (#211 - thanks @StGalant).
* Removed install generator. Users now need to create the initializer and locale
  files manually when needed.

## 2.2.2

* Fix compatibility with Sprockets 3.0.

## 2.2.1

* Rollback to [jhollingworth/bootstrap-wysihtml5](https://github.com/jhollingworth/bootstrap-wysihtml5).

  Sadly, Bootsrap3-wysihtml5 has proven to be just another unreliable fork that,
  apart from an initial enthusiasm, ended up as any other fork of the original
  library: abandoned and unresponsive.

## 2.2.0

* Move to [Bootstrap3-wysihtml5](https://github.com/bootstrap-wysiwyg/bootstrap3-wysiwyg).
  **This is backwards incompatible** if you rely on previous events or functions.
* New blockquote button - you can disable it in your initalizer.
* **This version is backwards incompatible if you are using custom locales**:
  New keys were added and the javascript locales structure was changed considerably.
  Please use [this file](https://github.com/volmer/bootsy/blob/master/app/assets/javascripts/bootsy/locales/pt-BR.js)
  as a reference and update your files accordingly.

## 2.1.0

* Rescue failed gallery upload (#111 - thanks @rzane).
* Allow uploading images from a url (#112 - thanks @rzane).
* Add a polyfill for Function.prototype.bind (#113 - thanks @rzane).
* Default locale to `en` if translations are missing (#24).

## 2.0.13

* Fix install generator (#110).

## 2.0.12

* Allow youtube embed codes (#71 - thanks @markusherzog).

## 2.0.11

* Fix orange color (#94).
* Fix locale generator (#95).

## 2.0.10

* Fix event handling for Turbolinks on Internet Explorer (#43).
* Fix helper inclusion when `ApplicationController` is eager loaded (#85).

## 2.0.9

* Fix editor for hidden textareas in Firefox.

## 2.0.8

* Do not rely on the `visible` state to check if an elemant was already initialized (#48).
* Do not autosave the bootsy resource when an `ImageGallery` is saved (#54).
* Bootsy is now compatible with Simple Form `3.1`.

## 2.0.7

* Updated Carrierwave dependency to `0.10.0`.

## 2.0.6

* Fixed support to foreign containers.
* Fixed scroll to top when inserting images (#40).
* Warn when the `bootsy:install` generator doesn't find the assets manifests.
* Fixed compatibility with [Turbolinks](https://github.com/rails/turbolinks) (#43).

## 2.0.5

* Update `mini_magick` dependency to `3.7.0`.

## 2.0.4

* Index editors in `Bootsy` namespace through the `textarea` `id`.
* Fixed compatibility with nested attributes. Now Bootsy can be used in `fields_for` blocks.
* Initialize only visible `bootsy_areas`. Other elements can be initialized by manually
  calling `Bootsy.init();`.

## 2.0.3

* Fixed object reference in `text_area` form helper.

## 2.0.2

* Fixed param key for scoped models.

## 2.0.1

* Fixed Glyphicons classes.

## 2.0.0

* Migrated Bootsy to Bootstrap 3 (backwards incompatible).
* Removed custom events (backwards incompatible).
* Now it's possible to have multiple editors in the same page (thanks @link-er).

## 1.2.0

* Merged the [SimpleForm](https://github.com/plataformatec/simple_form) support into master.
  You no longer need to use the [bootsy-simple_form](https://github.com/volmer/bootsy-simple_form)
  gem in your project.

## 1.1.0

* Design and interaction improvements. Bootsy is a lot more 'ajaxy' now, and loads images
  without flashing. This also changed the way deleting an image works. It no longer
  'refreshes the gallery', but instead finds the element to delete, fades it out,
  and removes it (thanks @anthonycollini).
* Fixed the indent and outdent icons as the icons were reversed from what they
  should be (thanks @anthonycollini).
* `z-index` fix to allow the contextual drop-down menus to properly appear over the footer and
  modal if it includes a longer list (thanks @anthonycollini).
* A default message if there are no uploaded images (thanks @anthonycollini).
* Bootsy now uses [Bootstrap File Input](https://github.com/grevory/bootstrap-file-input) with
  auto submission on file input change (thanks @anthonycollini).

## 1.0.0

* Now Bootsy is compatible with Rails `4.0` - *Backwards incompatibility*: Bootsy does not support
  Rails `3.2` anymore. We strongly recomend to move on and upgrade outdated projects to Rails `4.0`.
  If you didn't upgrade your project yet, you can use
  [our branch with *temporary* support for Rails `3.2`](https://github.com/volmer/bootsy/tree/rails-3.2).
* Bootsy now accepts file storage in cloud services like Amazon S3 and others.
  In `config/intializers/bootsy.rb`, just set a new attribute called `storage`
  as :fog. If you do that, please add 'fog' to your Gemfile and create and
  configure your service's credentials in an   initializer file, as described in [Carrierwave's docs](https://github.com/carrierwaveuploader/carrierwave/blob/master/README.md#using-amazon-s3).
* It is possobile now to delete orphan image galleries. Just call `.destroy_orphans` with a time limit:

```ruby
Bootsy::ImageGallery.destroy_orphans(1.day.ago)
```

* Now it's possible to fully clear the editor in the client side, by calling the function `clear()` in your Bootsy area:

```javascript
Bootsy.areas[0].clear();
```
