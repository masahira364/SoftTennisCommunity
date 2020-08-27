class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id, null: false
      t.integer :team_id, null: false
      t.timestamps

      t.index [:user_id, :team_id], unique: true
    end
  end
end
