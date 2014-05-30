class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         validates :first_name, presence: true
         validates :weight, presence: true, numericality: { only_integer: true }
         validates :height, presence: true
         validates :zipcode, presence: true, length: { is: 5 }, numericality: { only_integer: true }
         validates :bio, presence: true, length: { in: 17..170, too_short: "must have at least %{count} words",
             too_long: "must have at most %{count} words" }
end
