class ChangeRepostIdToBeOptional < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :repost_id, :integer, null: true
  end
end
