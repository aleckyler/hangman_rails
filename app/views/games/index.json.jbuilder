json.array!(@games) do |game|
  json.extract! game, :id, :player_cell, :player_email, :name, :host_name, :player_name, :word, :lives, :underscore_array, :word_array, :available_letters
  json.url game_url(game, format: :json)
end
