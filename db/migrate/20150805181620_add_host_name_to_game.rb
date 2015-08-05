class AddHostNameToGame < ActiveRecord::Migration
  def change
    add_column :games, :host_name, :string
  end
end
