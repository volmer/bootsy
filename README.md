Bootsy
==========

*Bootsy* is a WYSIWYG solution for Rails based on [Bootstrap-wysihtml5](https://github.com/jhollingworth/bootstrap-wysihtml5) which includes image uploads via [Carrierwave](https://github.com/jnicklas/carrierwave).


## Requirements

* Ruby MRI >= 1.9.3;
* Rails >= 3.2.6;
* Twitter Bootstrap properly integrated in your project's assets pipeline.


## Installation

1. Add Bootsy to your GemFile:

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

4. Add and run migrations:
  ```console
  rake bootsy:install:migrations
  rake db:migrate
  ```


## Usage

Just call the brand new method `bootsy_textarea` in your `FormBuilder` instances, in the same way that you call the basic `textarea` method. Example:

  ```erb
  <%= form_for(@post) do |f| %>
    <%= f.label :title %><br />
    <%= f.text_field :title %>

    <%= f.label :content %><br />
    <%= f.bootsy_area :content %>
    
    <%= f.submit %>
  <% end %>
  ```

Bootsy will group the uploaded image files as galleries and associate them to one of your models. For example, if you have a `Post` model and you want to use `bootsy_textarea` with it, then you should include the `MediaContainer` module:

  ```ruby
  class Post < ActiveRecord::Base
    include Bootsy::MediaContainer
    
    attr_accessible :content, :title
  end
  ```


## I18n

Bootsy defines some i18n keys. The english translation is automatically added to your `config/locales` directory as `bootsy.en.yml`. You can follow that template in order to translate Bootsy for your language.


## Mongoid support

Par default, Bootsy only supports ActiveRecord. A [Mongoid support](https://github.com/volmer/bootsy-mongoid) is currently in development.


## License

MIT License. Copyright 2012 Volmer Soares