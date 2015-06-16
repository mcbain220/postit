class ChangeUseridInPosts < ActiveRecord::Migration
  def change
    change_column :posts, :user_id, :integer
  end
end


# to correct mistake made in original creation of user_id column as string