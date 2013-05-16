class Post < ActiveRecord::Base
  attr_accessible :title, :body

  def self.search(query)
  	mapped_query = sanitize_sql_array ["to_tsquery('english', ?)", query]
  	conditions =  <<-eos
 		search_vector	@@  #{mapped_query}
     eos

     order = <<-eos
     	ts_rank_cd(search_vector, #{mapped_query}) DESC
     eos
    where(conditions).order(order)
  end


  def self.search1(query)
  	conditions =  <<-eos
 	 to_tsvector('english', 
 	 	coalesce(title,'') || ' ' || coalesce(body, '')
 	 	) @@  to_tsquery('english', ?)
     eos
    find(:all, :conditions => [conditions, query])
  end
end
