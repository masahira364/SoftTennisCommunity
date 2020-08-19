class CreateApprovals < ActiveRecord::Migration[5.2]
  def change
    create_table :approvals do |t|
      t.integer :user_id, null: false
      t.integer :team_id, null: false

      t.timestamps
    end
  end
end
