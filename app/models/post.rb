class Post < ActiveRecord::Base
  attr_accessible :title, :body

  def self.search(query)
  	conditions =  <<-eos
 	 to_tsvector('english', title) @@ to_tsquery('english', ?)
     eos
  	where(conditions,query)
  end
end
