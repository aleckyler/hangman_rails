json.array!(@plays) do |play|
  json.extract! play, :id, :guess, :game_id
  json.url play_url(play, format: :json)
end
