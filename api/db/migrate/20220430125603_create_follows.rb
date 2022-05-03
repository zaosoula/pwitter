class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.integer :target_id
      t.integer :source_id
      t.timestamps
    end
  end
end
