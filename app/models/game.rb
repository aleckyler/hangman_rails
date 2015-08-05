class Game < ActiveRecord::Base
  validates :host_name, :player_name, :word, presence: true
  has_many :plays
end
