# Bootsy

[![Build Status](https://secure.travis-ci.org/volmer/bootsy.png?branch=master)](http://travis-ci.org/volmer/bootsy)
[![Dependency Status](https://gemnasium.com/volmer/bootsy.png)](https://gemnasium.com/volmer/bootsy)

*Bootsy* is a WYSIWYG solution for Rails based on [Bootstrap-wysihtml5](https://github.com/jhollingworth/bootstrap-wysihtml5) which includes image uploads via [CarrierWave](https://github.com/jnicklas/carrierwave).


## Requirements

* Ruby MRI >= 1.9.3;
* ImageMagick or GraphicsMagick (for MiniMagick);
* Rails >= 3.2.6;
* [Twitter Bootstrap](http://twitter.github.com/bootstrap/) assets added on your application.


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
  rails g bootsy:install
  ```

4. Add and run migrations (if you are using ActiveRecord):
  ```console
  rake bootsy:install:migrations
  rake db:migrate
  ```


## Usage

Just call the brand new method `bootsy_area` in your `FormBuilder` instances, in the same way you call the basic `textarea` method. Example:

  ```erb
  <%= form_for(@post) do |f| %>
    <%= f.label :title %><br />
    <%= f.text_field :title %>

    <%= f.label :content %><br />
    <%= f.bootsy_area :content %>
    
    <%= f.submit %>
  <% end %>
  ```

Bootsy will group the uploaded image files as galleries and associate them to one of your models. For example, if you have a `Post` model and you want to use `bootsy_area` with it, then you should include the `Bootsy::Container` module:

  ```ruby
  class Post < ActiveRecord::Base
    include Bootsy::Container
    
    attr_accessible :content, :title
  end
  ```

## Editor options

It's possible to customize how the editor is displayed and its behavior by passing a hash `editor_options` to your `bootsy_area`.


### Buttons

You can enable/disable the buttons available in the editor. For example, if you want to disable the link and color buttons:

  ```erb
  <%= f.bootsy_area :my_attribute, editor_options: {link: false, color: false} %>
  ```
Available options are: `:font_styles`, `:emphasis`, `:lists`, `:html`, `:link`, `:image` and `:color`.


### Alert for usaved changes

By default, Bootsy alerts for unsaved changes if the user attempts to unload the window. You can disable it by doing:

  ```erb
  <%= f.bootsy_area :my_attribute, editor_options: {alert_unsaved: false} %>
  ```

### Uploader

It is also possible to disable the image upload feature entirely. This way the user can insert images in his/her text by providing an image url. Simple and easy:

  ```erb
  <%= f.bootsy_area :my_attribute, editor_options: {uploader: false} %>
  ```
*Note*: this option is automatically defined if you use `bootsy_area` without a `Bootsy::Container` model.


## Configuration

You can set the image sizes available (small, medium, large and/or its original), its dimensions and more. Take a look at the initalizer file, `/config/initializers/bootsy.rb`.


## I18n

Bootsy defines some i18n keys. The english translation is automatically added to your `config/locales` directory as `bootsy.en.yml`. You can follow that template in order to translate Bootsy for your language. You can find some examples [here](https://github.com/volmer/bootsy/tree/master/config/locales). It is also necessary to add a translation for Bootstrap-wysihtml5, the javascript editor, in your assets pipeline. Instructions [here](https://github.com/jhollingworth/bootstrap-wysihtml5#i18n). 


## Mongoid support

Par default, Bootsy only supports ActiveRecord. In order to use Bootsy with Mongoid, please use [bootsy-mongoid](https://github.com/volmer/bootsy-mongoid) instead.


## Bootsy with SimpleForm

Do you want to use Bootsy alongside with [SimpleForm](https://github.com/plataformatec/simple_form)? Take a look at [Bootsy-SimpleForm](https://github.com/volmer/bootsy-simple_form).


## License

MIT License. Copyright 2012 Volmer Soares