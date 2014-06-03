class ProfilesController < ApplicationController
  
  before_action :authenticate_user!

def new
  @profile = Profile.new
  @heights = (56..112).to_a.map { |inch| [ id: inch.to_s, name: (inch/12).floor.to_s+'\''+(inch%12).to_s ] }
  
end

def create
  @profile = Profile.new(profile_params)
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
end

def edit
  @profile = Profile.find(params[:id])
end

def update
	@profile = Profile.find(params[:id])
	
	if @profile.update(profile_params)
		redirect_to @profile
	else
		render 'edit'
	end
end

private

def profile_params
  params.require(:profile).permit(:first_name, :zipcode, :height, :weight, :bio, :kids, :pets, :birthday, :avatar)
end

end