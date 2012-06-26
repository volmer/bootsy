class Post < ActiveRecord::Base
  include Bootsy::MediaContainer
  attr_accessible :content, :title
end
