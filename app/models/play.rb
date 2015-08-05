class Play < ActiveRecord::Base
  validates :guess, length: { is: 1 }
  belongs_to :game
end
