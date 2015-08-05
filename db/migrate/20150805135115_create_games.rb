class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :word
      t.string :lives
      t.string :underscore_array
      t.string :word_array
      t.string :available_letters

      t.timestamps null: false
    end
  end
end
