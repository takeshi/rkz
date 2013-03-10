class Post < ActiveRecord::Base
  attr_accessible :contents, :owner_id, :title

  belongs_to :owner,:class_name=>"User"
end
