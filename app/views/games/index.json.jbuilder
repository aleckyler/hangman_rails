json.array!(@games) do |game|
  json.extract! game, :id, :name, :word, :lives, :underscore_array, :word_array, :available_letters
  json.url game_url(game, format: :json)
end
