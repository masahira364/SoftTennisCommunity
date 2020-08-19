class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.integer :user_id, null: false
      t.integer :event_id, foreign_key: true, null: false
      t.timestamps
    end
  end
end
