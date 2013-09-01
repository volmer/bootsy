class Article < ActiveRecord::Base
  include Bootsy::Container

  validates_presence_of :title, :content, :intro
end
