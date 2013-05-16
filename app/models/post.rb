class Post < ActiveRecord::Base
  attr_accessible :title, :body

  def self.search(query)
  	conditions =  <<-eos
 	 to_tsvector('english', 
 	 	coalesce(title,'') || ' ' || coalesce(body, '')
 	 	) @@  to_tsquery('english', ?)
     eos
    find(:all, :conditions => [conditions, query])
  end
end
