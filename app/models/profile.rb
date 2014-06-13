# require 'carrierwave/orm/activerecord'

class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  
  # mount_uploader :avatar, AvatarUploader
  
  geocoded_by :zipcode # zipcode is an attribute of the Profile model
  after_validation :geocode, :if => :zipcode_changed?
  
  acts_as_taggable
  acts_as_taggable_on :likes, :dislikes
  
  validates :first_name, presence: true
  validates :gender, presence: true
  validates :weight, presence: true, numericality: { only_integer: true }
  validates :height, presence: true, numericality: { only_integer: true } 
  validates :zipcode, presence: true, length: { is: 5 }, numericality: true
  validates :tagline, presence: true, length: {in: 1..140}
  # validates :agelimit, numericality: {only_integer: true}
  validates :bio, presence: true, length: { in: 1..170, too_short: "must have at least %{count} words",
      too_long: "must have at most %{count} words" }
      # increse bio min limit
      
end
