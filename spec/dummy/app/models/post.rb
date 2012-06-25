class Post < ActiveRecord::Base
  include Bootsy::Imageable
  attr_accessible :content, :title
end
