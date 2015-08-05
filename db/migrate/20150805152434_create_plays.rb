class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.text :guess
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
