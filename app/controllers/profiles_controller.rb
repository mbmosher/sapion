class ProfilesController < ApplicationController
  
  before_action :authenticate_user!
  
  require 'date'

def new
  @profile = Profile.new
  @heights = (56..112).to_a.map { |inch| [ id: inch.to_s, name: (inch/12).floor.to_s+'\''+(inch%12).to_s ] }
  
end

def create
  @profile = Profile.new(profile_params)
  cords = Geocoder.coordinates(@profile.zipcode.to_s)
	@profile.latitude = cords.first
	@profile.longitude = cords.last
  @profile.user_id = current_user.id
  @profile.rank = 0
  @profile.subscribed = false
  
  if @profile.save
    redirect_to @profile
  else
    render 'new'
  end
end

def show
  @profile = Profile.find(params[:id])
  @fav = current_user.favorites.find_by star_id: @profile.id
  @con = nil
  current_user.conversations.each do |convo|
    if convo.initiator == @profile.user_id || convo.mark == @profile.user_id
      @con = convo
    end
  end
  if current_user.conversations.last
    if DateTime.now - 1.day > current_user.conversations.last.created_at
      @newcon = true
    else
      @newcon = false
    end
  else
    @newcon = true
  end
  
end

def edit
  @profile = Profile.find(params[:id])
end

def update
	@profile = Profile.find(params[:id])
	
	cords = Geocoder.coordinates(@profile.zipcode.to_s)
	@profile.latitude = cords.first
	@profile.longitude = cords.last
	
	if @profile.update(profile_params)
		redirect_to @profile
	else
		render 'edit'
	end
end

def destroy
  @profilee = Profile.find(params[:id])
  @profile.destroy
  redirect_to welcome_path
end

private

def profile_params
  params.require(:profile).permit(:first_name, :agelimit, :zipcode, :height, :weight, :bio, :kids, :pets, :birthday, :avatar, :gender, :orientation, :like_list, :dislike_list, :single, :tagline)
end

end