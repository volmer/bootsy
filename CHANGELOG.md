# Bootsy Changelog

## 1.0.0

*Backwards incompatibility*: Bootsy does not support Rails `3.2` anymore. We strongly recomend to move
on and upgrade outdated projects to Rails `4.0`. If you didn't upgrade your project yet, you can use
[our branch with *temporary* support for Rails `3.2`](https://github.com/volmer/bootsy/tree/rails-3.2).

## 0.4.0

* Bootsy now accepts file storage in cloud services like Amazon S3 and others.
  In `config/intializers/bootsy.rb`, just set a new attribute called `storage`
  as :fog. If you do that, please add 'fog' to your Gemfile and create and
  configure your service's credentials in an   initializer file, as described in [Carrierwave's docs](https://github.com/carrierwaveuploader/carrierwave/blob/master/README.md#using-amazon-s3).


## 0.3.0

* Now Bootsy is compatible with Rails 4.0;
* It is possobile now to delete orphan image galleries. Just call `.destroy_orphans` with a time limit:

```ruby
Bootsy::ImageGallery.destroy_orphans(1.day.ago)
```

* Now it's possible to fully clear the editor in the client side, by calling the function `clear()` in your Bootsy area:

```javascript
Bootsy.areas[0].clear();
```
