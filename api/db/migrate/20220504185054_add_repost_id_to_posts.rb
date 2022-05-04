class AddRepostIdToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :repost_id, :integer
  end
end
