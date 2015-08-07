class Play < ActiveRecord::Base
  # validates :guess, format: { with: /\A[a-zA-Z]+\z/, message: "Guesses must be a letter" }
  validates :guess, length: { is: 1, message: 'Guesses can only be one letter.' }
  belongs_to :game
end
