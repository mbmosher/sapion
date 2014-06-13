require 'carrierwave/orm/activerecord'

class Photo < ActiveRecord::Base
  belongs_to :profile
  
  mount_uploader :avatar, AvatarUploader
  
  validates :caption, length: {in: 0..140}
end
