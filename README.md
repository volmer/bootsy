# Bootsy

[![Gem Version](https://badge.fury.io/rb/bootsy.png)](http://badge.fury.io/rb/bootsy)
[![Build Status](https://secure.travis-ci.org/volmer/bootsy.png?branch=master)](http://travis-ci.org/volmer/bootsy)
[![Dependency Status](https://gemnasium.com/volmer/bootsy.png)](https://gemnasium.com/volmer/bootsy)
[![Code Climate](https://codeclimate.com/github/volmer/bootsy.png)](https://codeclimate.com/github/volmer/bootsy)
[![Coverage Status](https://coveralls.io/repos/volmer/bootsy/badge.png?branch=master)](https://coveralls.io/r/volmer/bootsy)

*Bootsy* is a WYSIWYG editor for Rails based on
[Bootstrap3-wysihtml5](https://github.com/bootstrap-wysiwyg/bootstrap3-wysiwyg) with image uploads using
[CarrierWave](https://github.com/carrierwaveuploader/carrierwave).

### Live demo

* [bootsy-demo.herokuapp.com](http://bootsy-demo.herokuapp.com/)
[![image](https://f.cloud.github.com/assets/301187/1365250/e1b7ba80-3854-11e3-9bfe-8bd1e090aca8.png)](http://bootsy-demo.herokuapp.com/)


## Requirements

* ImageMagick or GraphicsMagick (for MiniMagick);
* Rails `4`;
* [Bootstrap `3`](http://getbootstrap.com/) fully installed in your app.


## Installation

1. Add Bootsy to your Gemfile:
  ```ruby
  gem 'bootsy'
  ```

2. Run the bundle command to install it:
  ```console
  bundle install
  ```

3. Run the install generator:
  ```console
  rails generate bootsy:install
  ```
  It will include the javascripts and stylesheets in the assets pipeline,
  create the `bootsy.rb` initializer and add a copy of the english translations.

  **Note:** If your project uses SASS or LESS and `application.css` does not exist,
  you will be required to require bootsy manually using `*= require bootsy` or if you prefer
  to import assets yourself `@import "bootsy";`

4. Add and run migrations:
  ```console
  rake bootsy:install:migrations
  rake db:migrate
  ```


## Usage

Just call `bootsy_area` in your `FormBuilder` instances, the
same way you'd call `textarea`. Example:
```erb
<%= form_for(@post) do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>

  <%= f.label :content %>
  <%= f.bootsy_area :content %>

  <%= f.submit %>
<% end %>
```

Bootsy will group the uploaded images as galleries and associate them to one of
your models. For instance, if you have a `Post` model and you want to use `bootsy_area`
with it, you must include the `Bootsy::Container` module:
```ruby
class Post < ActiveRecord::Base
  include Bootsy::Container
end
```

Don't forget to ensure the association between your model objects with Bootsy
image galleries. For `strong_parameters`, you must whitelist the `bootsy_image_gallery_id` parameter
in your controller:
```ruby
private

def post_params
  params.require(:post).permit(:title, :content, :bootsy_image_gallery_id)
end
```


## Bootsy with [Simple Form](https://github.com/plataformatec/simple_form) builders

You can use `bootsy` as an input type in `SimpleForm::FormBuilder` instances. Example:
```erb
<%= simple_form_for @post do |f| %>
  <%= f.input :title %>

  <%= f.input :content, as: :bootsy %>

  <%= f.button :submit %>
<% end %>
```


## Editor options

You can customize Bootsy through a hash of `editor_options`:


### Enable/disable features

You can enable and disable features as you like. For instance, if you don't want link and color features:
```erb
<%= f.bootsy_area :my_attribute, editor_options: { link: false, color: false } %>
```
Available options are: `:blockquote`, `:font_styles`, `:emphasis`, `:lists`, `:html`, `:link`, `:image` and `:color`.


### Alert of unsaved changes

By default Bootsy alerts the user about unsaved changes if the page is closed or reloaded. You can disable
this feature with:
```erb
<%= f.bootsy_area :my_attribute, editor_options: { alert_unsaved: false } %>
```

## Uploads

If you don't want to have image uploads, just call `bootsy_area` in a form builder not
associated to a `Bootsy::Container` model. This way users will still be able to insert
images in the text area using an external image URL.


## Configuration

You can set the default editor options, image sizes available (small, medium,
large and/or its original), dimensions and more. Take a look at Bootsy's initalizer
file `/config/initializers/bootsy.rb` in your app and feel free to uncomment and change
the options as you like.


## I18n

Bootsy defines some I18n keys. English translations are added by default to your
`config/locales` directory as `bootsy.en.yml`. You can use it as a template
to translate Bootsy to your language.
[Here are some examples](https://github.com/volmer/bootsy/tree/master/config/locales).

You also need to translate Bootsy on the JavaScript side. Just follow
[this example](https://github.com/volmer/bootsy/blob/master/app/assets/javascripts/bootsy/locales/en.js).
Bootsy will try to guess the locale based on the `lang` attribute of the page's `<html>` tag.
You can set the locale directly by setting a `data-bootsy-locale` attribute on your `<textarea>`.


## Contributing

### Running the tests

Before sending a pull request, you'll want to run the tests.  The first time you'll need to create and
migrate the dummy rails app's sqlite db.

  ```console
  cd spec/dummy
  bundle exec rake db:create RAILS_ENV=test
  bundle exec rake db:migrate RAILS_ENV=test
  cd ../..
  ```

 Then run rubocop/tests with:

 ```console
 bundle exec rake
 ```

## License

MIT License. Copyright 2012-2015 Volmer Soares
