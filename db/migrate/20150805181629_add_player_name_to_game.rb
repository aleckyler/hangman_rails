class AddPlayerNameToGame < ActiveRecord::Migration
  def change
    add_column :games, :player_name, :string
  end
end
