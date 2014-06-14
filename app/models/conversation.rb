class Conversation < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  has_many :interactions
  has_many :users, :through => :interactions, dependent: :destroy
  # has_many :messages, dependat: :destroy
end
