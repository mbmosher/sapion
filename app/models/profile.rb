class Profile < ActiveRecord::Base
  belongs_to :user
  
  validates :first_name, presence: true
  validates :weight, presence: true, numericality: { only_integer: true }
  validates :height, presence: true, numericality: { only_integer: true } 
  validates :zipcode, presence: true, length: { is: 5 }, numericality: { only_integer: true }
  validates :bio, presence: true, length: { in: 1..170, too_short: "must have at least %{count} words",
      too_long: "must have at most %{count} words" }
      
end
