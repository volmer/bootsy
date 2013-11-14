# Bootsy

[![Gem Version](https://badge.fury.io/rb/bootsy.png)](http://badge.fury.io/rb/bootsy)
[![Build Status](https://secure.travis-ci.org/volmer/bootsy.png?branch=master)](http://travis-ci.org/volmer/bootsy)
[![Dependency Status](https://gemnasium.com/volmer/bootsy.png)](https://gemnasium.com/volmer/bootsy)
[![Code Climate](https://codeclimate.com/github/volmer/bootsy.png)](https://codeclimate.com/github/volmer/bootsy)
[![Coverage Status](https://coveralls.io/repos/volmer/bootsy/badge.png?branch=master)](https://coveralls.io/r/volmer/bootsy)

*Bootsy* is a WYSIWYG solution for Rails based on [Bootstrap-wysihtml5](https://github.com/jhollingworth/bootstrap-wysihtml5) which includes image uploads via [CarrierWave](https://github.com/carrierwaveuploader/carrierwave).

![image](https://f.cloud.github.com/assets/301187/1365250/e1b7ba80-3854-11e3-9bfe-8bd1e090aca8.png)


## Requirements

* Ruby `2.0` or `1.9.3`;
* ImageMagick or GraphicsMagick (for MiniMagick);
* Rails `4.0`;
* [Bootstrap `3`](http://getbootstrap.com/) properly added to your application.


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

4. Add and run migrations (if you're using ActiveRecord):
```console
rake bootsy:install:migrations
rake db:migrate
```


## Usage

Just call the brand new method `bootsy_area` in your `FormBuilder` instances, the
same way you'd call the basic `textarea` method. Example:
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
your models. For example, if you have a `Post` model and you want to use `bootsy_area`
with it, then you should include the `Bootsy::Container` module:
```ruby
class Post < ActiveRecord::Base
  include Bootsy::Container
end
```

Don't forget to ensure the association of new instances of your model with Bootsy
image galleries. For `strong_parameters`, you must allow the parameter `bootsy_image_gallery_id`
in your controllers. Example:
```ruby
private
# Never trust parameters from the scary internet, only allow the white list through.
def post_params
  params.require(:post).permit(:title, :content, :bootsy_image_gallery_id)
end
```


## Bootsy with [Simple Form](https://github.com/plataformatec/simple_form) builders

Just use the brand new input type `bootsy` in your `SimpleForm::FormBuilder` instances,
in the same way you would use the basic `text` input. Example:
```erb
<%= simple_form_for @post do |f| %>
  <%= f.input :title %>

  <%= f.input :content, as: :bootsy %>

  <%= f.button :submit %>
<% end %>
```


## Editor options

It is possible to customize how the editor is displayed and its behavior by passing
a hash `editor_options` to your `bootsy_area`.


### Buttons

You can enable/disable the buttons available on the editor. For example, if you
want to disable the link and color buttons:
```erb
<%= f.bootsy_area :my_attribute, editor_options: {link: false, color: false} %>
```
Available options are: `:font_styles`, `:emphasis`, `:lists`, `:html`, `:link`, `:image` and `:color`.


### Alert for usaved changes

By default, Bootsy alerts for unsaved changes if the user attempts to unload
the window. You can disable this behaviour by doing:
```erb
<%= f.bootsy_area :my_attribute, editor_options: {alert_unsaved: false} %>
```

## Uploader

It's also possible to use Bootsy without the image upload feature. Just call
`bootsy_area` in a form builder not associated to a `Bootsy::Container` model.
This way users can insert images in their texts by providing an image url.


## Configuration

You can set the default editor options, image sizes available (small, medium,
large and/or its original), its dimensions and more. Take a look at the initalizer
file, `/config/initializers/bootsy.rb`.


## I18n

Bootsy defines some i18n keys. The english translation is automatically added
to your `config/locales` directory as `bootsy.en.yml`. You can follow that template
in order to translate Bootsy to your language. You can find some examples
[here](https://github.com/volmer/bootsy/tree/master/config/locales). It is also
necessary to add a translation for Bootstrap-wysihtml5, the javascript editor, in
your assets pipeline. Instructions [here](https://github.com/jhollingworth/bootstrap-wysihtml5#i18n).
If you are using the alert for unsaved changes, you have to define a translation
for it as well. Just follow [this example](https://github.com/volmer/bootsy/tree/master/app/assets/bootsy/locales/bootsy.pt-BR.js).


## License

MIT License. Copyright 2013 Volmer Soares
