class AddPlayerCellToGame < ActiveRecord::Migration
  def change
    add_column :games, :player_cell, :string
  end
end
