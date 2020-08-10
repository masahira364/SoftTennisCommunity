class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :slogan, null: false
      t.string :address, null: false
      t.string :practice_day, null: false
      t.integer :number_of_people, null: false
      t.integer :average_age, null: false
      t.integer :annual_fee, null: false
      t.integer :entry_fee, null: false
      t.text :members_wanted, null: false
      t.text :introduction, null: false
      t.string :homepage
      t.string :contact_infomation
      t.string :image_id
      t.integer :user_id
      t.integer :article_id
      t.integer :prefecture_id
      t.integer :event_id
      t.timestamps
    end
  end
end
