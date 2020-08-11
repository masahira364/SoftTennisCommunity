class AddPrefectureCodeToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :prefecture_code, :integer
  end
end
