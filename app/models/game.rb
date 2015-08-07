class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not a valid email")
    end
  end
end

class Game < ActiveRecord::Base

  validates :host_name, :player_name, :word, presence: true
  validates :player_cell, numericality: true, allow_blank: true
  validates :player_cell, length: { is: 10 , message: "must include the area code and can not include hyphens or parenthesis." }, allow_blank: true

  validates :player_email, email: true, allow_blank: true
  # validates :player_email, numericality: true, allow_blank: true
  # validates :player_email, length: { is: 10 , message: "must include the area code and can not include hyphens or parenthesis." }, allow_blank: true

  validates :word, format: { with: /\A[a-zA-Z ]+\z/, message: "can only include letters and spaces." }
  has_many :plays
end
