class Game < ActiveRecord::Base
  validates :name, :word, presence: true
end
