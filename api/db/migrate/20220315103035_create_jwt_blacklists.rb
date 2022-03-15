class CreateJwtBlacklists < ActiveRecord::Migration[7.0]
  def change
    create_table :jwt_blacklists do |t|
      t.string :jti, null: false
      t.datetime :exp
    end
    add_index :jwt_blacklists, :jti
  end
end
