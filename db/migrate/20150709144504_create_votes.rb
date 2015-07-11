class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
    	t.boolean :vote
    	t.integer :user_id
    	t.string :voteable_type   # could also do t.references :voteable, polymorphic: true to cover this and next line
    	t.integer :voteable_id
    	t.timestamps
    end
  end
end
