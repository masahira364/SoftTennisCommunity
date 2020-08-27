class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :email
      t.string :slogan, null: false
      t.integer :prefecture_code, null: false
      t.integer :postal_code, null: false
      t.string :address, null: false
      t.string :practice_day
      t.integer :number_of_people
      t.string :annual_fee, null: false
      t.string :entry_fee, null: false
      t.boolean :members_wanted, null: false
      t.text :recruitment_targrt
      t.text :introduction
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :homepage_url
      t.string :image_id
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
