class Comment < ActiveRecord::Base
  if Rails::VERSION::STRING.split(".").first.to_i >= 5
    belongs_to :post, optional: true
  else
    belongs_to :post
  end
end
