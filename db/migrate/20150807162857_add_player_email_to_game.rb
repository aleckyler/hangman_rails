class AddPlayerEmailToGame < ActiveRecord::Migration
  def change
    add_column :games, :player_email, :string
  end
end
