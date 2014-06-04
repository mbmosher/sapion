class Conversation < ActiveRecord::Base
  has_many :messages
  has_many :users, :through => :messages, dependent: :destroy
  # has_many :messages, dependat: :destroy
end
