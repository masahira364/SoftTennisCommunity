class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.timestamps

      t.index [:user_id, :event_id], unique: true
    end
  end
end
