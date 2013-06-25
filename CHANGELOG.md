# Bootsy Changelog

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
