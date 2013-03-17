require 'redcarpet/compat'

class Post < ActiveRecord::Base
  attr_accessible :contents, :owner_id, :title

  belongs_to :owner,:class_name=>"User"

  def markdown_contents
    Markdown.new(contents).to_html
  end
end
