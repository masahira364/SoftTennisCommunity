class CreateApprovals < ActiveRecord::Migration[5.2]
  def change
    create_table :approvals do |t|
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end
