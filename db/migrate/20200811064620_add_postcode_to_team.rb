class AddPostcodeToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :postcode, :integer
  end
end
