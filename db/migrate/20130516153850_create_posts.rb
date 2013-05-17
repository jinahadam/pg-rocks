class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :body
      t.column :search_vector, 'tsvector'
      t.boolean :published, :null => false

      t.timestamps
    end

    execute <<-eos
    	CREATE INDEX posts_search_idx ON posts USING gin(search_vector)
    eos

     execute <<-eos
    	CREATE UNIQUE INDEX posts_title ON posts (lower(title)) WHERE published
    eos

    execute <<-eos
    	CREATE TRIGGER posts_vector BEFORE INSERT OR UPDATE 
    	ON posts
    	FOR EACH ROW EXECUTE PROCEDURE 
    		tsvector_update_trigger(search_vector, 'pg_catalog.english',
    			body,title);
     eos

     Post.find_each {|p| p.touch}

  end
end
