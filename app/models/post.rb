class Post < ActiveRecord::Base
  attr_accessible :contents, :owner_id, :title
end
